//
//  MenuViewCell.m
//  Kapu
//
//  Created by Kamlesh Dubey on 9/3/15.
//  Copyright (c) 2015 Digillence Rolson. All rights reserved.
//

#import "MenuViewCell.h"

@implementation MenuViewCell
@synthesize nameLabel,thumbnailImageView,thumbImg;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
