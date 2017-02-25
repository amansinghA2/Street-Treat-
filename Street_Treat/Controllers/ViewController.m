//
//  ViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 5/12/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize splashImgView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [delegate.defaults setObject:@"ViewController" forKey:@"internetdisconnect"];
    self.navigationController.navigationBarHidden = TRUE;
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(![delegate.defaults valueForKey:@"logid"]){
        duration = 0.5;
         NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(showLoginController) userInfo:nil repeats: NO];
    }else{
        duration = 1.5;
         NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(showDashboardController) userInfo:nil repeats: NO];
    }
  
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GoTapped:)];
//     tapGestureRecognizer.numberOfTapsRequired = 1;
//     [splashImgView addGestureRecognizer:tapGestureRecognizer];
}

//- (IBAction)GoTapped:(UIGestureRecognizer *)sender{
//    LoginViewController * login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//    login.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self.navigationController presentViewController:login animated:YES completion:nil];
//    //[self.navigationController pushViewController:login animated:YES];
//}

-(void)showLoginController{
    LoginViewController * login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:login animated:YES];
}

-(void)showDashboardController{
    UITabBarController *tabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"Street_TreatTabbar"];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:tabbar animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
