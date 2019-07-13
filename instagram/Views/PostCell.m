//
//  PostCell.m
//  instagram
//
//  Created by britneyting on 7/9/19.
//  Copyright © 2019 britneyting. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"

@import Parse;

@implementation PostCell

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
