//
//  BestDealsViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/26/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BestDealsCell.h"
#import "Common.h"
#import "AppDelegate.h"
#import "NotificationsViewController.h"
#import "ProfileViewController.h"
#import "HelpViewController.h"
#import "ViewController.h"

@interface BestDealsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shortDealTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *longDealTitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *ExpandBtn;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *storeCatLbl;

@end

@interface BestDealsViewController : UIViewController<commonProtocol,UITableViewDelegate,UITableViewDataSource,CCKFNavDrawerDelegate>{
    Common * commonclass;
    AppDelegate * delegate;
    NSMutableData * dealsdata;
    NSMutableArray * dealsArr;
    NSArray * smalldealsArr;
    BestDealsCell * cell;
    
    BOOL isexpand, isselecttapped;
    NSIndexPath * path;
    long selectedIndex;
    NSMutableArray *indexpathArr;
    NSString * setType;
    UIView * flyoutView;
    UITextField *txfSearchField;
    float userLatitude,userLongitude,userRadius,currentLatitude,currentLongitude;
}

@property (strong, nonatomic) CCKFNavDrawer *rootNav;
@property (weak, nonatomic) IBOutlet UILabel *offerCntLbl;
@property (weak, nonatomic) IBOutlet UITableView *OffersTable;
@property (weak, nonatomic) IBOutlet UILabel *pageTitle;
//@property (weak, nonatomic) IBOutlet UILabel *offerCntLbl;


//@property (weak, nonatomic) IBOutlet UICollectionView *DealsCollectionView;



@end
