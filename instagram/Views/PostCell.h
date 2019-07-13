//
//  PostCell.h
//  instagram
//
//  Created by britneyting on 7/9/19.
//  Copyright © 2019 britneyting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@import Parse;

@interface PostCell : UITableViewCell

@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *usernameTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameBottomLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

// for the profile picture
@property (strong, nonatomic) IBOutlet PFImageView *profilePictureView;

// for the post's picture
@property (strong, nonatomic) IBOutlet PFImageView *photoImageView;

// for profile picture, segue to the profileviewcontroller, but instead of current user, make a new public object that is named User and then grab all that user's details.
@end

NS_ASSUME_NONNULL_END
