//
//  BucketsListingViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/22/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "BucketsListingViewController.h"

@interface BucketsListingViewController (){
    UIView *contentView;
    UPStackMenu *stack;
}


@end

@implementation BucketsListingViewController
@synthesize bucketsTable;

-(void)viewDidAppear:(BOOL)animated{
    [self getBuckets];
    [self setUpstackMenu];
}

-(void)viewWillAppear:(BOOL)animated{
    [delegate.defaults setObject:@"BucketsListingViewController" forKey:@"internetdisconnect"];
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
//    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
//    back.hidden = true;
    [commonclass setNavigationController:self.navigationController tabBarController:self.tabBarController];
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    [self showLocName];
    //[back addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
}

-(void)showLocName{
    
    //    if ([[delegate.defaults valueForKey:@"myloc"] isEqualToString:@"locupdatefrom"]){
    //        txfSearchField.text = [delegate.defaults valueForKey:@"myloc_name"];
    //                txfSearchField.textColor = [UIColor whiteColor];
    //                [self getNearbyDealsWithLatitude:currentLatitude longitude:currentLongitude radius:userRadius];
    //                [timer invalidate];
    //    }else{
    //        txfSearchField.text = [delegate.defaults valueForKey:@"loc_name"];
    //            NSString * loc = [delegate.defaults valueForKey:@"loc_name"];
    //            if(loc.length == 0){
    //                txfSearchField.text = [delegate.defaults valueForKey:@"myloc_name"];
    //            }
    //                txfSearchField.textColor = [UIColor whiteColor];
    //                [self getNearbyDealsWithLatitude:currentLatitude longitude:currentLongitude radius:userRadius];
    //                [timer invalidate];
    //        }
    
    //    if ([[delegate.defaults valueForKey:@"myloc"] isEqualToString:@"locupdatefrom"]){
    //        searchField.text = [delegate.defaults valueForKey:@"myloc_name"];
    //    }else{
    //        searchField.text = [delegate.defaults valueForKey:@"loc_name"];
    //    }
    
    NSString * loc = [delegate.defaults valueForKey:@"loc_name"];
    if(loc.length == 0){
        txfSearchField.text = [delegate.defaults valueForKey:@"myloc_name"];
        txfSearchField.textColor = [UIColor whiteColor];
        //        [self getNearbyDealsWithLatitude:currentLatitude longitude:currentLongitude radius:userRadius];
        //        [timer invalidate];
    }else{
        txfSearchField.text = [delegate.defaults valueForKey:@"loc_name"];
        txfSearchField.textColor = [UIColor whiteColor];
        //        [self getNearbyDealsWithLatitude:currentLatitude longitude:currentLongitude radius:userRadius];
        //        [timer invalidate];
    }
    //NSLog(@"loc.. %@",loc);
}

-(void)setUpstackMenu{
    contentView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height + 5 , 35, 35)];
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

#pragma mark - UPStackMenuDelegate
- (void)setStackIconClosed:(BOOL)closed{
    UIImageView *icon = [[contentView subviews] objectAtIndex:0];
    float angle = closed ? 0 : (M_PI * (135) / 180.0);
    [UIView animateWithDuration:0.3 animations:^{
        [icon.layer setAffineTransform:CGAffineTransformRotate(CGAffineTransformIdentity, angle)];
    }];
}

- (void)stackMenuWillOpen:(UPStackMenu *)menu{
    flyoutView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/1.3, self.view.frame.size.width, self.view.frame.size.height/4)];
    flyoutView.backgroundColor = [UIColor whiteColor];
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
    
    if(index == 0){
        [delegate.defaults setValue:@"Favourites" forKey:@"route"];
        [commonclass Redirect:self.navigationController Identifier:@"ResultsViewController"];
    }else if(index == 1){
        [commonclass Redirect:self.navigationController Identifier:@"ProfileViewController"];
    }else if (index == 2){
        
    }
    [stack closeStack];
//    NSString *message = [NSString stringWithFormat:@"Item touched : %@", item.title];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden =true;
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [commonclass addNavigationBar:self.view];
    bucketslistData = [[NSMutableData alloc]init];
    bucketsListArr = [[NSMutableArray alloc]init];
    
    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
    back.hidden = true;
    UIButton *notifications = (UIButton *)[self.view viewWithTag:222];
    [notifications addTarget:self action:@selector(notificationsTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *Menu = (UIButton *)[self.view viewWithTag:111];
    [Menu addTarget:self action:@selector(MenuToggle) forControlEvents:UIControlEventTouchUpInside];
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    [current_Loc addTarget:self action:@selector(FindCurrentTapped) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    txfSearchField = [search valueForKey:@"_searchField"];
    txfSearchField.text = [delegate.defaults valueForKey:@"loc_name"];
    txfSearchField.textColor = [UIColor whiteColor];
    search.userInteractionEnabled = FALSE;
    
    
}

-(void)FindCurrentTapped{
    [delegate.defaults setValue:@"myloc" forKey:@"locupdatefrom"];
    txfSearchField.text = [delegate.defaults valueForKey:@"myloc_name"];
   [self getBuckets];
}


-(void)notificationsTapped{
    NotificationsViewController * notifications = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    [self presentViewController:notifications animated:YES completion:nil];
}

-(void)MenuToggle{
    [self.rootNav drawerToggle];
}

-(void)CCKFNavDrawerSelection:(NSInteger)selectedSession selectedRow: (NSInteger) row {
    [commonclass DrawerTapped:selectedSession selectedRow: row];
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [viewController viewWillAppear:YES];
    
}

-(void)getBuckets{
     if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&orderdesc=ASC&orderby=ordering",[delegate.defaults valueForKey:@"logid"]];
    NSLog(@"body.. %@",messageBody);
     NSLog(@"commonclass.bucketsListURL.. %@",commonclass.bucketsListURL);
    [commonclass sendRequest:self.view mutableDta:bucketslistData url:commonclass.bucketsListURL msgBody:messageBody];
     }else{
         [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data.. %@",data);
     dispatch_sync(dispatch_get_main_queue(), ^{
         [bucketsListArr removeAllObjects];
         if([[data valueForKey:@"status"]intValue] == 1){
             bucketsListArr = [data valueForKey:@"items"];
             //NSLog(@"bucketsListArr %lu",[[[data valueForKey:@"items"] valueForKey:@"buckets"] count]);
             [bucketsTable reloadData];
         }else if([[data valueForKey:@"status"]intValue] == -1){
             [commonclass logoutFunction];
         }else{
             
         }
        // NSLog(@"Buckets List.. %@",bucketsListArr);
    
        [indicator stopAnimating];
         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

//-(void)backTapped{
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return [bucketsListArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    cellIdentifier = @"Buckets";
    cell = (BucketsListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[BucketsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bucketSelectView.backgroundColor = [UIColor redColor];
    cell.bucketListImg.image = [UIImage imageNamed:@"BucketlistBack.png"];
    cell.bucketListLbl.text = [NSString stringWithFormat:@"  %@",[[bucketsListArr[indexPath.section] valueForKey:@"title"] uppercaseString]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    cell = [tableView cellForRowAtIndexPath:indexPath];
    //cell.bucketSelectView.backgroundColor = [UIColor Tabbar_Color];
    long int bucketID = [[bucketsListArr[indexPath.section] valueForKey:@"id"] intValue];
    NSString *bucketId1 = [bucketsListArr[indexPath.section] valueForKey:@"id"];
    NSString * title = [[bucketsListArr[indexPath.section] valueForKey:@"title"] uppercaseString];
    [delegate.defaults setInteger:bucketID forKey:@"bucketID"];
    [delegate.defaults setValue:bucketId1 forKey:@"category"];
    [delegate.defaults setObject:@"fromBucket" forKey:@"isFromBucket"];
    [delegate.defaults setValue:title forKey:@"bucketName"];
    [delegate.defaults setValue:@"Buckets" forKey:@"route"];
    [delegate.defaults synchronize];
    [commonclass Redirect:self.navigationController Identifier:@"ResultsViewController"];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    cell = [tableView cellForRowAtIndexPath:indexPath];
    //cell.bucketSelectView.backgroundColor = [UIColor redColor];
}

-(void)viewDidDisappear:(BOOL)animated{
    [contentView removeFromSuperview];
    [stack removeFromSuperview];
    [flyoutView removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
