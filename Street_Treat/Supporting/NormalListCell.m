//
//  NormalListCell.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/11/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "NormalListCell.h"

@implementation NormalListCell
@synthesize storeNameLbl,storeAddLbl,storeStarsLbl,storeRatingLbl,storeShopForLbl,storeTimeLbl,storeAwayLbl,storeValidCpnCodeLbl,storeAwayIconLbl,storecheckInBtn,storePhoneBtn,storeGalleryView,storeDiscLbl,storeTreatsLbl;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
