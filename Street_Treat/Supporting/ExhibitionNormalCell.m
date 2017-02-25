//
//  ExhibitionNormalCell.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/19/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "ExhibitionNormalCell.h"

@implementation ExhibitionNormalCell
@synthesize storeNameLbl,storeAddLbl,storeTimeLbl,storeAwayLbl,storeAwayIconLbl,storecheckInBtn,storePhoneBtn,storeDateLbl,storeAttendingLbl,storeGalleryView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
