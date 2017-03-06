//
//  BucketListPagerViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 9/8/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "BucketListPagerViewController.h"

@interface BucketListPagerViewController ()

@end

@implementation BucketListPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [delegate.defaults setObject:@"BucketListPagerViewController" forKey:@"internetdisconnect"];
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
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

@end
