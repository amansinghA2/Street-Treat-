//
//  StaticDataViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/28/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "StaticDataViewController.h"
#import "Common.h"

@interface StaticDataViewController ()

@end

@implementation StaticDataViewController
@synthesize getType,DataLbl,staticDataView,dataWebview,webview,titleLbl,indicatorwebview;

- (void)viewDidLoad {
    [super viewDidLoad];
    [delegate.defaults setObject:@"StaticDataViewController" forKey:@"internetdisconnect"];
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    StaticData = [[NSMutableData alloc]init];
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    [commonclass addNavigationBar:self.view];
    webview.delegate = self;
    
    
    
    indicatorwebview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorwebview.color = [UIColor lightGrayColor];
    indicatorwebview.center=webview.center;
    [dataWebview addSubview:indicatorwebview];
    
     NSLog(@"type.. %@",[delegate.defaults valueForKey:@"staticType"]);
    
    if([[delegate.defaults valueForKey:@"staticType"] isEqualToString:@"about-us"]){
        staticDataView.hidden = false;
        [self.view bringSubviewToFront:staticDataView];
        titleLbl.text = @"ABOUT US";
        requestType = @"About";
        if([commonclass isActiveInternet] == YES){
        NSString *messageBody = [NSString stringWithFormat:@"title=%@",[delegate.defaults valueForKey:@"staticType"]];
        NSLog(@"body.. %@",messageBody);
        [commonclass sendRequest:self.view mutableDta:StaticData url:commonclass.staticDataURL msgBody:messageBody];
        }else{
            [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
            //[self.view makeToast:@"Check your internet connection"];
        }
    }else if ([[delegate.defaults valueForKey:@"staticType"] isEqualToString:@"News-Events"]){
        titleLbl.text = @"NEWS & EVENTS";
        dataWebview.hidden = false;
        [self.view bringSubviewToFront:dataWebview];
        NSString *urlString = commonclass.newsEventsURL;
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }else if ([[delegate.defaults valueForKey:@"staticType"] isEqualToString:@"Terms And Conditions"]){
        titleLbl.text = @"TERMS & CONDITIONS";
        dataWebview.hidden = false;
        [self.view bringSubviewToFront:dataWebview];
        NSString *urlString = commonclass.termsconditionsURL;
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }else if ([[delegate.defaults valueForKey:@"staticType"] isEqualToString:@"faqs"]){
        titleLbl.text = @"FAQ'S";
        dataWebview.hidden = false;
        [self.view bringSubviewToFront:dataWebview];
        NSString *urlString = commonclass.FAQsURL;
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }else if ([[delegate.defaults valueForKey:@"staticType"] isEqualToString:@"privacy"]){
        titleLbl.text = @"PRIVACY POLICY";
        dataWebview.hidden = false;
        [self.view bringSubviewToFront:dataWebview];
        NSString *urlString = commonclass.privacypolicyURL;
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }
    
    UIButton *backBtn = (UIButton *)[self.view viewWithTag:1111];
    [backBtn addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *menubtn = (UIButton *)[self.view viewWithTag:111];
    menubtn.hidden = TRUE;
    UIButton *notificationbtn = (UIButton *)[self.view viewWithTag:222];
    notificationbtn.hidden = TRUE;
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    current_Loc.hidden = TRUE;

    
   
    
//    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    indicator.color = [UIColor lightGrayColor];
//    indicator.center=self.view.center;
//    [self.view addSubview:indicator];
//    [indicator startAnimating];
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"result DataResponse.. %@",[[data valueForKey:@"items"] valueForKey:@"content"]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        if(data != NULL){
            NSString * htmlString = [[data valueForKey:@"items"] valueForKey:@"content"];
            NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
//            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//            [paragraphStyle setAlignment:NSTextAlignmentCenter];
//            
//            //NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
//            [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, 100)];
            
            DataLbl.attributedText = attrStr;
            [DataLbl sizeToFit];
        }else{
            
        }
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
   [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
   [indicatorwebview startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [indicatorwebview stopAnimating];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
