//
//  NormalListCell.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/11/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *storeNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeAddLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeStarsLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeRatingLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeShopForLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeAwayIconLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeAwayLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeValidCpnCodeLbl;
@property (weak, nonatomic) IBOutlet UIButton *storecheckInBtn;
@property (weak, nonatomic) IBOutlet UIButton *storePhoneBtn;
@property (weak, nonatomic) IBOutlet UIView *storeGalleryView;
@property (weak, nonatomic) IBOutlet UILabel *storeDiscLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeTreatsLbl;




@end
