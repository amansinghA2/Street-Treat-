//
//  InternetDisconnectViewController.m
//  Street_Treat
//
//  Created by Aman on 24/02/17.
//  Copyright © 2017 Digillence Rolson. All rights reserved.
//

#import "InternetDisconnectViewController.h"

@interface InternetDisconnectViewController ()

@end

@implementation InternetDisconnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    common = [[Common alloc]init];
    common.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tryAgain:(id)sender {

    NSString *viewControllerString = [delegate.defaults valueForKey:@"internetdisconnect"];
    
    if([common isActiveInternet] == YES){
    if ([viewControllerString isEqualToString:@"LoginViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"LoginViewController"];
    }else if ([viewControllerString isEqualToString:@"ViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"ViewController"];
    }else if ([viewControllerString isEqualToString:@"DashboardViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"DashboardViewController"];
    }else if ([viewControllerString isEqualToString:@"ResultsViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
       [common Redirect:self.navigationController Identifier:@"ResultsViewController"];
    }else if ([viewControllerString isEqualToString:@"DetailViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"DetailViewController"];
    }else if ([viewControllerString isEqualToString:@"ForgotPassViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"ForgotPassViewController"];
    }else if ([viewControllerString isEqualToString:@"ProfileViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"ProfileViewController"];
    }else if ([viewControllerString isEqualToString:@"VerifyViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"VerifyViewController"];
    }else if ([viewControllerString isEqualToString:@"ReportErrorViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"ReportErrorViewController"];
    }else if ([viewControllerString isEqualToString:@"SubmitReviewViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"SubmitReviewViewController"];
    }else if ([viewControllerString isEqualToString:@"ViewReviewsViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"ViewReviewsViewController"];
    }else if ([viewControllerString isEqualToString:@"VerticalsViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"VerticalsViewController"];
    }else if ([viewControllerString isEqualToString:@"ExhibitionListingViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"ExhibitionListingViewController"];
    }else if ([viewControllerString isEqualToString:@"BucketsListingViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"BucketsListingViewController"];
    }else if ([viewControllerString isEqualToString:@"NearMeViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"NearMeViewController"];
    }else if ([viewControllerString isEqualToString:@"BestDealsViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"BestDealsViewController"];
    }else if ([viewControllerString isEqualToString:@"HelpViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"HelpViewController"];
    }else if ([viewControllerString isEqualToString:@"GenerateCouponsViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
    }else if ([viewControllerString isEqualToString:@"CheckoutReviewViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"CheckoutReviewViewController"];
    }else if ([viewControllerString isEqualToString:@"MyCouponsViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"MyCouponsViewController"];
    }else if ([viewControllerString isEqualToString:@"SearchStoreViewController"]){
        [self.navigationController popViewControllerAnimated:YES];
        [common Redirect:self.navigationController Identifier:@"SearchStoreViewController"];
    }
    }else{
        [self.view makeToast:@"Check Internet connection and try again"];
    //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Wi-Fi"]];
    }
    
}

@end
