//
//  DetailsViewController.m
//  instagram
//
//  Created by britneyting on 7/10/19.
//  Copyright © 2019 britneyting. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchData];
}

- (void)fetchData {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    
    // Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    // Convert Date to String
    self.dateLabel.text = [formatter stringFromDate:self.post.createdAt];
    
    self.usernameLabel.text = self.post.author.username;
    [self setPost:self.post];
    NSURL *postURL = [NSURL URLWithString:self.post.image.url];
    [self.photoImageView setImageWithURL:postURL];
    self.likesLabel.text = [NSString stringWithFormat:@"%@", self.post.likeCount];
    self.likesLabel.text = [self.likesLabel.text stringByAppendingString:@" Likes"];
    self.commentsLabel.text = [NSString stringWithFormat:@"%@", self.post.commentCount];
    self.commentsLabel.text = [self.commentsLabel.text stringByAppendingString:@" Comments"];
    self.captionLabel.text = self.post.caption;
    self.username2Label.text = self.post.author.username;
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
