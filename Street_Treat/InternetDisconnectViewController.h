//
//  InternetDisconnectViewController.h
//  Street_Treat
//
//  Created by Aman on 24/02/17.
//  Copyright © 2017 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Common.h"
#import "ResultsViewController.h"
#import "DashboardViewController.h"

@interface InternetDisconnectViewController : UIViewController<commonProtocol>{
    AppDelegate *delegate;
    Common *common;
}
- (IBAction)tryAgain:(id)sender;

@end
