//
//  BucketListPagerViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 9/8/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "AppDelegate.h"
#import "BucketsListCell.h"

@interface BucketListPagerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,commonProtocol>{
    Common * commonclass;
    AppDelegate * delegate;
    BucketsListCell * cell;
    NSMutableData * bucketslistData;
    NSMutableArray * bucketsListArr;
}

@property (weak, nonatomic) IBOutlet UITableView *bucketsTable;

@end
