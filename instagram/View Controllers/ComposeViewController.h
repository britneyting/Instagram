//
//  ComposeViewController.h
//  instagram
//
//  Created by britneyting on 7/9/19.
//  Copyright © 2019 britneyting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate // Need this here bc any other view controllers could potentially be presenting the ComposeViewController, not just the TimelineViewController. This protocol creates a contract betwen the ComposeViewController and whichever view controller presented it.

- (void)didPost; // the controller that conforms to the above protocol needs to implement this method inside so they can communicate with each other

@end

@interface ComposeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareBarButton;
@property (weak, nonatomic) IBOutlet UIImageView *uploadImage;
@property (weak, nonatomic) IBOutlet UITextView *uploadText;
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;



@end

NS_ASSUME_NONNULL_END
