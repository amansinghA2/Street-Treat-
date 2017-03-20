//
//  StaticDataViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/28/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Common.h"
#import "UPStackMenu.h"

@interface StaticDataViewController : UIViewController<commonProtocol,UIWebViewDelegate , UPStackMenuDelegate>
{
    NSString *post;
    NSData *postData;
    NSString *postLength;
    NSMutableURLRequest *request;
    NSURLConnection *theConnection;
    NSMutableData *StaticData;
    AppDelegate * delegate;
    Common * commonclass;
    NSString* requestType;
    UIView * flyoutView;
}

@property (nonatomic, strong) NSString * getType;
//@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *DataLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *staticDataView;
@property (weak, nonatomic) IBOutlet UIView *dataWebview;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic)  UIActivityIndicatorView *indicatorwebview;

@end
