//
//  BucketsListingViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/22/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "AppDelegate.h"
#import "BucketsListCell.h"
#import "ResultsViewController.h"
#import "UPStackMenu.h"

@interface BucketsListingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,commonProtocol,UITabBarControllerDelegate,CCKFNavDrawerDelegate,UPStackMenuDelegate>{
    Common * commonclass;
    AppDelegate * delegate;
    BucketsListCell * cell;
    NSMutableData * bucketslistData;
    NSMutableArray * bucketsListArr;
    NSString * setType;
    UIView * flyoutView;
    
    UITextField *txfSearchField;
    
    
}

@property (weak, nonatomic) IBOutlet UITableView *bucketsTable;
@property (strong, nonatomic) CCKFNavDrawer *rootNav;

@end
