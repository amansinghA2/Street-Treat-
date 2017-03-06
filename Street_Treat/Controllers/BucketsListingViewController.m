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
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    
    //[back addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
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

-(void)CCKFNavDrawerSelection:(NSInteger)selectionIndex{
    [self DrawerTapped:selectionIndex];
}

#pragma mark - photoShotSavedDelegate
- (void)DrawerTapped:(NSInteger)selectionIndex{
    if([[delegate.defaults valueForKey:@"drawerRoute"] isEqualToString:@"Section"]){
        NSLog(@"index.. %ld",(long)selectionIndex);
        switch (selectionIndex) {
            case 0:
            {
                SearchStoreViewController * searchStore = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchStoreViewController"];
                // [self.navigationController pushViewController:searchStore animated:NO];
                //MyModalViewController *modalViewController = [[MyModalViewController alloc] init];
                [searchStore setReferencedNavigation:self.navigationController];
                searchStore.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self.tabBarController presentViewController:searchStore animated:YES completion:nil];
            }
                break;
            case 1:
            {
                NSString * catID = [delegate.defaults valueForKey:@"MensCategory"];
                [delegate.defaults setValue:catID forKey:@"category"];
                [delegate.defaults setValue:@"Store" forKey:@"route"];
                [delegate.defaults synchronize];
                [self showResults];
            }
                break;
            case 2:
            {
                NSString * catID = [delegate.defaults valueForKey:@"WomensCategory"];
                [delegate.defaults setValue:catID forKey:@"category"];
                [delegate.defaults setValue:@"Store" forKey:@"route"];
                [delegate.defaults synchronize];
                [self showResults];
            }
                break;
            case 3:
            {
                NSString * catID = [delegate.defaults valueForKey:@"ChildrenCategory"];
                [delegate.defaults setValue:catID forKey:@"category"];
                [delegate.defaults setValue:@"Store" forKey:@"route"];
                [delegate.defaults synchronize];
                [self showResults];
            }
                break;
            case 4:
                // [self showExhibitions];
                break;
            case 5:
                setType = @"about-us";
                [self StaticContent];
                break;
            case 6:
                setType = @"News-Events";
                [self StaticContent];
                break;
            case 7:
                setType = @"Terms And Conditions";
                [self StaticContent];
                break;
            case 8:
                setType = @"faqs";
                [self StaticContent];
                break;
            case 9:
                setType = @"privacy";
                [self StaticContent];
                break;
            case 10:{
                [commonclass Redirect:self.navigationController Identifier:@"ContactViewController"];
                //                ContactViewController * contact = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactViewController"];
                //                [self.navigationController pushViewController:contact animated:YES];
            }
                break;
            case 11:{
                ProfileViewController * profile = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                [self.navigationController pushViewController:profile animated:YES];
                self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
            }
                break;
            case 12:{
                //                ChangePasswordViewController * password = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
                //                [self.navigationController pushViewController:password animated:YES];
                //                self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
            }
                break;
            case 13:{
                HelpViewController * help = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpViewController"];
                [self.navigationController pushViewController:help animated:YES];
                self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
            }
                break;
            case 14:{
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                [delegate.defaults setValue:@"19.1183" forKey:@"latitude"];
                [delegate.defaults setValue:@"73.0276" forKey:@"longitude"];
                //[delegate.defaults setValue:@"Mahape" forKey:@"loc_name"];
                [delegate.defaults setValue:@"3" forKey:@"radius"];
                ViewController * splash = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                UINavigationController *passcodeNavigationController = [[UINavigationController alloc] initWithRootViewController:splash];
                [self presentViewController:passcodeNavigationController animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
    }
    else{
        if(selectionIndex == 1){
            
        }
        if(selectionIndex == 2){
            
        }
        if(selectionIndex == 3){
            
        }
        if(selectionIndex == 4){
            
        }
    }
}

-(void)showResults{
    [delegate.defaults setObject:@"Category" forKey:@"resultType"];
    [delegate.defaults synchronize];
    ResultsViewController * result = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultsViewController"];
    [self.navigationController pushViewController:result animated:YES];
    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
}

-(void)StaticContent{
    //NSLog(@"type StaticContent .. %@",setType);
    [delegate.defaults setObject:setType forKey:@"staticType"];
    [delegate.defaults synchronize];
    StaticDataViewController * info = [self.storyboard instantiateViewControllerWithIdentifier:@"StaticDataViewController"];
    [self.navigationController pushViewController:info animated:YES];
    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
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
    NSString * title = [[bucketsListArr[indexPath.section] valueForKey:@"title"] uppercaseString];
    [delegate.defaults setInteger:bucketID forKey:@"bucketID"];
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
    //[stack removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
