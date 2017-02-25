//
//  ContactViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 6/28/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

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
