//
//  ContactViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/28/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController (){
    UIView *contentView;
    UPStackMenu *stack;
}

@end

@implementation ContactViewController
@synthesize addressLbl,telImg,telinfo,faxImg,faxInfo,mailImg,mailInfo,websiteLbl,indicator,mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [delegate.defaults setObject:@"ContactViewController" forKey:@"internetdisconnect"];
    commonclass = [[Common alloc]init];
    [commonclass addNavigationBar:self.view];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:19.1136 longitude:72.8697 zoom:14];
    mapView.camera = camera;
    mapView.myLocationEnabled = YES;
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(19.1111, 72.8656);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = @"Street-Treat";
    marker.map = mapView;
    [mapView setSelectedMarker:marker];

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

    

    
    contactData = [[NSMutableData alloc]init];
    telImg.text = commonclass.telIcon;
    faxImg.text = commonclass.faxIcon;
    mailImg.text = commonclass.mailIcon;
    
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.color = [UIColor lightGrayColor];
    indicator.center=self.view.center;
    [self.view addSubview:indicator];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [indicator startAnimating];
    [contactData setLength:0];
    //if((usertxtFld.text == nil && passTxtFld.text == nil) || usertxtFld.text == nil || passTxtFld.text == nil ){
    //        //[self.view makeToast:@"Please provide proper information"];
    //        [indicator stopAnimating];
    //    }else{
    NSURL *url = [NSURL URLWithString:commonclass.contactURL];
    request = [NSMutableURLRequest requestWithURL:url];
    NSString *messageBody = [NSString stringWithFormat:@""];
    NSLog(@"body.. %@",messageBody);
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[messageBody length]];
    [request setHTTPMethod:@"POST"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[messageBody dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"error:%@", error.localizedDescription);
                               }
                               [contactData appendData:data];
                               [self contactResponse:contactData];
                           }];

    
    // Do any additional setup after loading the view.
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

-(void)contactResponse:(NSData *)data{
    NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"result DataResponse.. %@",result);
    NSString * telephone = [NSString stringWithFormat:@"TEL. : %@",[[result valueForKey:@"items"] valueForKey:@"telephone"]];
    NSString * fax = [NSString stringWithFormat:@"FAX : %@",[[result valueForKey:@"items"] valueForKey:@"fax"]];
    NSString * mail = [NSString stringWithFormat:@"E-MAIL : %@",[[result valueForKey:@"items"] valueForKey:@"email"]];
    NSString * addressStr = [NSString stringWithFormat:@"%@",[[result valueForKey:@"items"] valueForKey:@"address"]];
    addressStr = [addressStr stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    dispatch_sync(dispatch_get_main_queue(), ^{
        
       addressLbl.text = addressStr;
        
        NSMutableAttributedString *string_tel = [[NSMutableAttributedString alloc] initWithString:telephone];
        NSRange selectedRangetel = NSMakeRange(0,6);
        [string_tel beginEditing];
        [string_tel addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Roboto-Bold" size:13] range:selectedRangetel];
        [string_tel endEditing];
        telinfo.attributedText = string_tel;
        
        NSMutableAttributedString *string_fax = [[NSMutableAttributedString alloc] initWithString:fax];
        NSRange selectedRangefax = NSMakeRange(0,5);
        [string_fax beginEditing];
        [string_fax addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Roboto-Bold" size:13] range:selectedRangefax];
        [string_fax endEditing];
        faxInfo.attributedText = string_fax;
        
        NSMutableAttributedString *string_mail = [[NSMutableAttributedString alloc] initWithString:mail];
        NSRange selectedRangemail = NSMakeRange(0,8);
        [string_mail beginEditing];
        [string_mail addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Roboto-Bold" size:13] range:selectedRangemail];
        [string_mail endEditing];
        mailInfo.attributedText = string_mail;
        
        websiteLbl.text = [[result valueForKey:@"items"] valueForKey:@"website"];
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
