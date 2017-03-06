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
        [common Redirect:self.navigationController Identifier:@"LoginViewController"];
    }else if ([viewControllerString isEqualToString:@"ViewController"]){
        [common Redirect:self.navigationController Identifier:@"ViewController"];
    }else if ([viewControllerString isEqualToString:@"DashboardViewController"]){
        [common Redirect:self.navigationController Identifier:@"DashboardViewController"];
    }else if ([viewControllerString isEqualToString:@"ResultsViewController"]){
       [common Redirect:self.navigationController Identifier:@"ResultsViewController"];
    }else if ([viewControllerString isEqualToString:@"ForgotPassViewController"]){
        [common Redirect:self.navigationController Identifier:@"ForgotPassViewController"];
    }else if ([viewControllerString isEqualToString:@"ProfileViewController"]){
        [common Redirect:self.navigationController Identifier:@"ProfileViewController"];
    }else if ([viewControllerString isEqualToString:@"VerifyViewController"]){
        [common Redirect:self.navigationController Identifier:@"VerifyViewController"];
    }else if ([viewControllerString isEqualToString:@"ReportErrorViewController"]){
        [common Redirect:self.navigationController Identifier:@"ReportErrorViewController"];
    }else if ([viewControllerString isEqualToString:@"SubmitReviewViewController"]){
        [common Redirect:self.navigationController Identifier:@"SubmitReviewViewController"];
    }else if ([viewControllerString isEqualToString:@"ViewReviewsViewController"]){
        [common Redirect:self.navigationController Identifier:@"ViewReviewsViewController"];
    }else if ([viewControllerString isEqualToString:@"VerticalsViewController"]){
        [common Redirect:self.navigationController Identifier:@"VerticalsViewController"];
    }else if ([viewControllerString isEqualToString:@"ExhibitionListingViewController"]){
        [common Redirect:self.navigationController Identifier:@"ExhibitionListingViewController"];
    }else if ([viewControllerString isEqualToString:@"BucketsListingViewController"]){
        [common Redirect:self.navigationController Identifier:@"BucketsListingViewController"];
    }else if ([viewControllerString isEqualToString:@"NearMeViewController"]){
        [common Redirect:self.navigationController Identifier:@"NearMeViewController"];
    }else if ([viewControllerString isEqualToString:@"BestDealsViewController"]){
        [common Redirect:self.navigationController Identifier:@"BestDealsViewController"];
    }else if ([viewControllerString isEqualToString:@"HelpViewController"]){
        [common Redirect:self.navigationController Identifier:@"HelpViewController"];
    }else if ([viewControllerString isEqualToString:@"GenerateCouponsViewController"]){
        [common Redirect:self.navigationController Identifier:@"GenerateCouponsViewController"];
    }else if ([viewControllerString isEqualToString:@"CheckoutReviewViewController"]){
        [common Redirect:self.navigationController Identifier:@"CheckoutReviewViewController"];
    }else if ([viewControllerString isEqualToString:@"MyCouponsViewController"]){
        [common Redirect:self.navigationController Identifier:@"MyCouponsViewController"];
    }else if ([viewControllerString isEqualToString:@"SearchStoreViewController"]){
        [common Redirect:self.navigationController Identifier:@"SearchStoreViewController"];
    }
    }else{
        [self.view makeToast:@"No Internet connection , Please try again"];
    }
    
}

@end
