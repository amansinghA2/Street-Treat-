//
//  BucketDetailViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 9/7/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "BucketDetailViewController.h"

@interface BucketDetailViewController ()

@end

@implementation BucketDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [delegate.defaults setObject:@"BucketDetailViewController" forKey:@"internetdisconnect"];
    [self getbucketDetails];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self allocateData];
    
}

-(void)allocateData{
    BucketsDtlData = [[NSMutableData alloc]init];
    BucketsDtlArr = [[NSMutableArray alloc]init];
    self.navigationController.navigationBarHidden =true;
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [commonclass addNavigationBar:self.view];
       
    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
    [back addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *menubtn = (UIButton *)[self.view viewWithTag:111];
    menubtn.hidden = TRUE;
    UIButton *notificationbtn = (UIButton *)[self.view viewWithTag:222];
    notificationbtn.hidden = TRUE;
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;

}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data.. %@",data);
    dispatch_sync(dispatch_get_main_queue(), ^{
        if([[data valueForKey:@"status"]intValue] == 1){
            BucketsDtlArr = data ;
//            NSLog(@"bucketsListArr %lu",[[[data valueForKey:@"items"] valueForKey:@"buckets"] count]);
//            [notificationsTable reloadData];
        }else if([[data valueForKey:@"status"]intValue] == -1){
            [commonclass logoutFunction];
        }
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getbucketDetails{
     if([commonclass isActiveInternet] == YES){
    responseType = @"BucketsDetail";
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&bucket_id=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"bucketID"]];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.bucketsDeatilURL);
    [commonclass sendRequest:self.view mutableDta:BucketsDtlData url:commonclass.bucketsDeatilURL msgBody:messageBody];
     }else{
         [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }

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
