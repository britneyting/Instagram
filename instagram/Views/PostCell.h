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

@property (weak, nonatomic) IBOutlet UILabel *usernameTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameBottomLabel;

@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) IBOutlet PFImageView *photoImageView;





@end

NS_ASSUME_NONNULL_END
