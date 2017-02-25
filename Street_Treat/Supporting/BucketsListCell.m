//
//  BucketsListCell.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/22/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "BucketsListCell.h"

@implementation BucketsListCell
@synthesize bucketListLbl,bucketListImg,bucketSelectView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
