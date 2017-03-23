//
//  ViewReviewsViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/5/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TableViewPagerViewController.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "Common.h"
#import "NotificationsViewController.h"

@interface PositiveReviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *usrCmntLbl;
@property (weak, nonatomic) IBOutlet UILabel *userCmntTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *userratingsLbl;
@property (weak, nonatomic) IBOutlet UITextField *vendorRplyTxtFld;


@end

@interface ViewReviewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,commonProtocol>{
    Common * commonclass;
    AppDelegate * delegate;
    
    NSMutableData * reviewsData;
    //NSMutableArray ;
    NSMutableArray * negativeArr,* allArr,* positiveArr;
    NSArray * AllArr;
    long int allcnt,positivecnt,negativecnt;
   // UITableView* v1, *v2,*v3;
    UIView *flyoutView;
    NSString * typeStr;
}

@property (weak, nonatomic) IBOutlet UILabel *reviewCntLbl;
@property (weak, nonatomic) IBOutlet UILabel *hdrLine;
@property (weak, nonatomic) IBOutlet UITableView *reviewsTable;
@property (weak, nonatomic) IBOutlet UIButton *AllBtn;
- (IBAction)AllTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *happyBtn;
- (IBAction)happyTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sadBtn;
- (IBAction)sadTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *indicatorLine;

@end
