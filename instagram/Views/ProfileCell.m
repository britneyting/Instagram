//
//  ProfileCell.m
//  instagram
//
//  Created by britneyting on 7/11/19.
//  Copyright © 2019 britneyting. All rights reserved.
//

#import "ProfileCell.h"
#import "Post.h"

@implementation ProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setPost:(Post *)post {
    _post = post;
    self.photoImageView.file = post[@"image"];
    [self.photoImageView loadInBackground];
}

@end
