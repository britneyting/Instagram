//
//  ProfileViewController.m
//  instagram
//
//  Created by britneyting on 7/11/19.
//  Copyright © 2019 britneyting. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCell.h"
#import "Parse/Parse.h"
#import "Post.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *profileCardView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UIImage *originalImage;
@property (strong, nonatomic) UIImage *editedImage;
@property (strong, nonatomic) UIImage *propic;

@property (strong, nonatomic) NSArray *posts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView setTableHeaderView:self.profileCardView];
    PFUser *currentUser = [PFUser currentUser];
    self.usernameHeaderLabel.text = currentUser.username;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self fetchData];
    
    // code for activity indicator (refresh)
    self.refreshControl = [[UIRefreshControl alloc] init]; // do self refreshControl instead of UIRefreshControl *refreshControl since we already declared the variable refreshControl in properties
    [self.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0]; // inserts the activity indicator at index0 (before the first tweet)
}

- (void)fetchData {
    
    [self.activityIndicator startAnimating];
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts) {
            // do something with the array of object returned by the call
            self.posts = posts;
            self.postsHeaderLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.posts.count];
            self.postsHeaderLabel.text = [self.postsHeaderLabel.text stringByAppendingString:@" Posts"];
            [self.tableView reloadData]; // step 7: reload the table view
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [self.refreshControl endRefreshing];
    [self.activityIndicator stopAnimating];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell" forIndexPath:indexPath];
    
    Post *post = self.posts[indexPath.row];
    
    cell.post = post;
    [cell setPost:post];
    cell.usernameLabel.text = post.author.username;
    cell.captionLabel.text = post.caption;
    cell.likesLabel.text = [NSString stringWithFormat:@"%@", post.likeCount];
    cell.likesLabel.text = [cell.likesLabel.text stringByAppendingString:@" Likes"];
    cell.commentsLabel.text = [NSString stringWithFormat:@"%@", post.commentCount];
    cell.commentsLabel.text = [cell.commentsLabel.text stringByAppendingString:@" Comments"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    
    // Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    // Convert Date to String
    cell.dateLabel.text = [formatter stringFromDate:cell.post.createdAt];
    
    return cell;
}

- (IBAction)editProfilePic:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    // calls camera if camera is available
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    // if camera is unavailable, then call photo library
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    self.editedImage = info[UIImagePickerControllerEditedImage];
    self.editedImage = [self resizeImage:self.originalImage withSize:CGSizeMake(400, 400)];
    
    // Do something with the images (based on your use case)
    
    [self.profilePic setImage:self.editedImage];
    self.propic = self.editedImage;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            // We have a post object (of PFObject class)
            // Get the image data and create a PFFileObject for that data
            NSData *imageData = UIImagePNGRepresentation(self.propic);
            PFFileObject *file = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
            
            // Set the image data to a key of the PFObject
            object[@"author"][@"profilePicture"] = file;
            
            // Save the object back to Parse backend
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    NSLog(@"Successfully uploaded new profile picture to backend");
                } else {
                    NSLog(@"%@", error.localizedDescription);
                }
            }];
        }
    }];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
