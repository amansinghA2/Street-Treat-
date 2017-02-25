//
//  ExhibitionNormalCell.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/19/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitionNormalCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *storeNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeAddLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeAwayIconLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeAwayLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeAttendingLbl;
@property (weak, nonatomic) IBOutlet UIButton *storecheckInBtn;
@property (weak, nonatomic) IBOutlet UIButton *storePhoneBtn;
@property (weak, nonatomic) IBOutlet UIView *storeGalleryView;

@end
