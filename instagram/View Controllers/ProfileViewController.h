//
//  ProfileViewController.h
//  instagram
//
//  Created by britneyting on 7/11/19.
//  Copyright © 2019 britneyting. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *usernameHeaderLabel;
@property (strong, nonatomic) IBOutlet UILabel *postsHeaderLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;

@end

NS_ASSUME_NONNULL_END
