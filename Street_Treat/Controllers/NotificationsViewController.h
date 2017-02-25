//
//  NotificationsViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 9/7/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "AppDelegate.h"
#import "NotificationsCell.h"

@interface NotificationsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,commonProtocol>{
    Common * commonclass;
    AppDelegate * delegate;
    NotificationsCell * cell;
    NSMutableData * NotificationData;
    NSMutableArray * notificationArr;
    
}
@property (weak, nonatomic) IBOutlet UITableView *notificationsTable;

@end
