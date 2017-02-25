//
//  NotificationsViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 9/7/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "NotificationsViewController.h"

@interface NotificationsViewController ()

@end

@implementation NotificationsViewController
@synthesize notificationsTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    [delegate.defaults setObject:@"NotificationsViewController" forKey:@"internetdisconnect"];
    self.navigationController.navigationBarHidden =true;
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [commonclass addNavigationBar:self.view];
    NotificationData = [[NSMutableData alloc]init];
    notificationArr = [[NSMutableArray alloc]init];
    
    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
    [back addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *menubtn = (UIButton *)[self.view viewWithTag:111];
    menubtn.hidden = TRUE;
    UIButton *notificationbtn = (UIButton *)[self.view viewWithTag:222];
    notificationbtn.hidden = TRUE;
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
    
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    current_Loc.hidden = TRUE;

    
 /*   NSString *messageBody = [NSString stringWithFormat:@"log_id=%@",[delegate.defaults valueForKey:@"logid"]];
    //dynamic
    //  NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%@&longitude=%@&radius=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],@"3"];
    NSLog(@"body.. %@",messageBody);
    [commonclass sendRequest:self.view mutableDta:bucketslistData url:commonclass.bucketsListURL msgBody:messageBody];*/

    // Do any additional setup after loading the view.
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    dispatch_sync(dispatch_get_main_queue(), ^{
        if([[data valueForKey:@"status"]intValue] == 1){
            notificationArr = data ;
            NSLog(@"bucketsListArr %lu",[[[data valueForKey:@"items"] valueForKey:@"buckets"] count]);
            [notificationsTable reloadData];
        }else if([[data valueForKey:@"status"]intValue] == -1){
            [commonclass logoutFunction];
        }
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

- (void)backTapped{
    UIButton *notifications = (UIButton *)[self.view viewWithTag:222];
    [notifications addTarget:self action:@selector(notificationsTapped1) forControlEvents:UIControlEventTouchUpInside];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)notificationsTapped1{
    NotificationsViewController * notifications = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    [self presentViewController:notifications animated:YES completion:nil];
}

//-(void)backTapped{
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   /* if([notificationArr count]==0){
        return 0;
    }else{
        return [[[notificationArr valueForKey:@"items"] valueForKey:@"buckets"] count];
    } */
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    //return [[[exhibitionsArr valueForKey:@"items"] valueForKey:@"Exhibitiondetails"] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    cellIdentifier = @"NotificationsCell";
    cell = (NotificationsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[NotificationsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   // cell.bucketListLbl.text = [NSString stringWithFormat:@"  %@",[[[[bucketsListArr valueForKey:@"items"] valueForKey:@"buckets"][indexPath.section] valueForKey:@"title"] uppercaseString]];
    
    return cell;
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
