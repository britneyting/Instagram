//
//  HomeFeedViewController.m
//  instagram
//
//  Created by britneyting on 7/8/19.
//  Copyright © 2019 britneyting. All rights reserved.
//

#import "HomeFeedViewController.h"
#import "Parse/Parse.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "PostCell.h"
#import "ComposeViewController.h"
#import "Post.h"

@interface HomeFeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts) {
            // do something with the array of object returned by the call
            self.posts = posts;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}

- (void)getTimeline {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    return 20;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"forIndexPath:indexPath];
    
    Post *post = self.posts[indexPath.row]; // Tweet class is blueprint for each tweet. (similar to NSDictionary *movie in FlixApp. We then call the tweets with self.tweets
    cell.post = post;
    cell.usernameTopLabel.text = post.author.username;
    cell.usernameBottomLabel.text = post.author.username;
    cell.captionLabel.text = post.caption;
    cell.likesLabel.text = [NSString stringWithFormat:@"%@", post.likeCount];
    cell.commentsLabel.text = [NSString stringWithFormat:@"%@", post.commentCount];
    
    
    return cell;
}


- (IBAction)logout:(id)sender {
    // when logout button is pressed, rootviewcontroller will be directed to login page so that when app is pressed again, user will be directed to login page instead of home feed
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    appDelegate.window.rootViewController = viewController;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
}

- (IBAction)compose:(id)sender {
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
