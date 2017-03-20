//
//  StaticDataViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/28/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "StaticDataViewController.h"
#import "Common.h"

@interface StaticDataViewController (){
    UIView *contentView;
    UPStackMenu *stack;
}

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

-(void)viewDidDisappear:(BOOL)animated{
    [contentView removeFromSuperview];
    [stack removeFromSuperview];
    [flyoutView removeFromSuperview];
}

-(void)viewDidAppear:(BOOL)animated{
    [self setUpstackMenu];
}

#pragma mark - UPStackMenuDelegate
- (void)setStackIconClosed:(BOOL)closed{
    UIImageView *icon = [[contentView subviews] objectAtIndex:0];
    float angle = closed ? 0 : (M_PI * (135) / 180.0);
    [UIView animateWithDuration:0.3 animations:^{
        [icon.layer setAffineTransform:CGAffineTransformRotate(CGAffineTransformIdentity, angle)];
    }];
}

- (void)stackMenuWillOpen:(UPStackMenu *)menu{
    flyoutView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/1.2, self.view.frame.size.width, self.view.frame.size.height/4)];
    flyoutView.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:flyoutView];
    if([[contentView subviews] count] == 0)
        return;
    [self setStackIconClosed:NO];
}

- (void)stackMenuWillClose:(UPStackMenu *)menu{
    [flyoutView removeFromSuperview];
    if([[contentView subviews] count] == 0)
        return;
    [self setStackIconClosed:YES];
}

- (void)stackMenu:(UPStackMenu *)menu didTouchItem:(UPStackMenuItem *)item atIndex:(NSUInteger)index{
    NSString *message = [NSString stringWithFormat:@"Item touched : %@", item.title];
    NSLog(@"index.. %lu",(unsigned long)index);
    if(index == 0){
        [delegate.defaults setValue:@"Favourites" forKey:@"route"];
        [commonclass Redirect:self.navigationController Identifier:@"ResultsViewController"];
    }else if(index == 1){
        [commonclass Redirect:self.navigationController Identifier:@"ProfileViewController"];
    }else if (index == 2){
        
    }
    [stack closeStack];
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //    [alert show];
}


-(void)setUpstackMenu{
    contentView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height + 5, 35, 35)];
    [contentView setBackgroundColor:[UIColor redColor]];
    [contentView.layer setCornerRadius:18.0f];
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plus"]];
    [icon setContentMode:UIViewContentModeScaleAspectFit];
    [icon setFrame:CGRectMake(contentView.frame.size.width/6, contentView.frame.size.height/6, 25, 25)];
    [contentView addSubview:icon];
    
    if(stack)
    [stack removeFromSuperview];
    stack = [[UPStackMenu alloc] initWithContentView:contentView];
    //[stack setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 20)];
    [stack setDelegate:self];
    
    UPStackMenuItem *squareItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Download_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"View Favourites"];
    UPStackMenuItem *circleItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Email_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"Update Profile"];
    UPStackMenuItem *viewItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"Email_Excel"] highlightedImage:[UIImage imageNamed:@"Download_Excel"] title:@"Add Reviews"];
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:squareItem, circleItem, nil];
    [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitleColor:[UIColor redColor]];
        //item.backgroundColor = [UIColor darkGrayColor];
    }];
    
    [stack setAnimationType:UPStackMenuAnimationType_progressive];
    [stack setStackPosition:UPStackMenuStackPosition_up];
    [stack setOpenAnimationDuration:.4];
    [stack setCloseAnimationDuration:.4];
    [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
        [item setLabelPosition:UPStackMenuItemLabelPosition_left];
        [item setLabelPosition:UPStackMenuItemLabelPosition_left];
    }];
    
    [stack addItems:items];
    
    [self.tabBarController.view addSubview:stack];
    
    [self setStackIconClosed:YES];
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
