//
//  DetailsViewController.h
//  instagram
//
//  Created by britneyting on 7/10/19.
//  Copyright © 2019 britneyting. All rights reserved.
//

#import "ViewController.h"
#import "Post.h"
#import "Parse/Parse.h"

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@protocol DetailsViewControllerDelegate<NSObject> // Need this here bc any other view controllers could potentially be presenting the ComposeViewController, not just the TimelineViewController. This protocol creates a contract betwen the ComposeViewController and whichever view controller presented it.

// UNCOMMENT BELOW FUNCTION IF YOU WANT TO ADD FAVORITE AND COMMENT
// - (void)updateData:(UIViewController *)viewController; // the controller that conforms to the above protocol needs to implement this method inside so they can communicate with each other

@end

@interface DetailsViewController : ViewController

@property (strong, nonatomic) Post *post;
//@property (nonatomic, weak) id<DetailsViewControllerDelegate> delegate; // The designation of weak with delegate properties has to do with ARC and avoiding memory leaks.
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet PFImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UIButton *likesButton;
@property (strong, nonatomic) IBOutlet UILabel *likesLabel;
@property (strong, nonatomic) IBOutlet UIButton *commentsButton;
@property (strong, nonatomic) IBOutlet UILabel *commentsLabel;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *username2Label;

@end

NS_ASSUME_NONNULL_END
