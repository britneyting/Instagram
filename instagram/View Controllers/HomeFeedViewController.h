//
//  HomeFeedViewController.h
//  instagram
//
//  Created by britneyting on 7/8/19.
//  Copyright © 2019 britneyting. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeFeedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *composeBarButton;
@property (strong, nonatomic) NSArray *posts;

@end

NS_ASSUME_NONNULL_END
