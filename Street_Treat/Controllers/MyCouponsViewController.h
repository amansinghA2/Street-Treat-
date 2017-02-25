//
//  MyCouponsViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 1/31/17.
//  Copyright © 2017 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "AppDelegate.h"

@interface MyCouponsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shortTextLbl;
@property (weak, nonatomic) IBOutlet UIButton *expandBtn;
@property (weak, nonatomic) IBOutlet UILabel *longTextLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLbl;
@end

@interface MyCouponsViewController : UIViewController<commonProtocol,UITableViewDataSource,UITableViewDelegate>{
    AppDelegate * delegate;
    Common * commonclass;
    NSString * requestType;
    NSMutableData * couponsData;
    NSMutableArray * mycouponsArr;
    NSMutableArray * awaitingArr,*cancelledArr,*validatedArr;
    BOOL isexpand, isselecttapped;
    NSIndexPath * path;
    MyCouponsCell * cell;
    long selectedIndex;
    NSString * seg_string;
}
@property (weak, nonatomic) IBOutlet UITableView *couponsTable;
@property (weak, nonatomic) IBOutlet UILabel *couponsCntLbl;

@property (weak, nonatomic) IBOutlet UIButton *approvalPendingBtn;
@property (weak, nonatomic) IBOutlet UIButton *approvalRecievedBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelledCouponsBtn;
@property (weak, nonatomic) IBOutlet UILabel *indicatorLine;


- (IBAction)ApprovalPendingTapped:(id)sender;
- (IBAction)ApprovalRecievedTapped:(id)sender;
- (IBAction)CancelledCouponsTapped:(id)sender;

@end
