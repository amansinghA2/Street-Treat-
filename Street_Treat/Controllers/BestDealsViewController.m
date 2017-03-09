//
//  BestDealsViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/26/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "BestDealsViewController.h"



@implementation BestDealsCell
@synthesize shortDealTitleLbl,longDealTitleLbl,ExpandBtn,storeNameLbl,storeCatLbl;
//@synthesize bucketListLbl,bucketListImg,bucketSelectView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@interface BestDealsViewController (){
    UIView *contentView;
    UPStackMenu *stack;
}

@end

@implementation BestDealsViewController
@synthesize offerCntLbl,OffersTable,rootNav;
//@synthesize DealsCollectionView;

-(void)viewWillAppear:(BOOL)animated{
    [delegate.defaults setObject:@"BestDealsViewController" forKey:@"internetdisconnect"];
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
    //[delegate.defaults setValue:@"mycoupons" forKey:@"BestDeals"];
    if([[delegate.defaults valueForKey:@"BestDeals"] isEqualToString:@"mycoupons"]){
        _pageTitle.text = @"MY COUPONS";
    }else{
        _pageTitle.text = @"NEARBY DEALS";
    }
    
    currentLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
    currentLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    userRadius = [[delegate.defaults valueForKey:@"radius"] floatValue];
}

-(void)viewDidAppear:(BOOL)animated{
    [self setUpstackMenu];
}

-(void)viewDidDisappear:(BOOL)animated{
    [contentView removeFromSuperview];
    [stack removeFromSuperview];
    [flyoutView removeFromSuperview];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden =true;
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [commonclass addNavigationBar:self.view];
    
    dealsdata = [[NSMutableData alloc]init];
    dealsArr = [[NSMutableArray alloc]init];
    
    isexpand = false;
    indexpathArr = [[NSMutableArray alloc]init];
    
    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
    [back addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    txfSearchField = [search valueForKey:@"_searchField"];
    txfSearchField.text = [delegate.defaults valueForKey:@"loc_name"];
    txfSearchField.textColor = [UIColor whiteColor];
    search.userInteractionEnabled = FALSE;
    UIButton *notifications = (UIButton *)[self.view viewWithTag:222];
    [notifications addTarget:self action:@selector(notificationsTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *Menu = (UIButton *)[self.view viewWithTag:111];
    [Menu addTarget:self action:@selector(MenuToggle) forControlEvents:UIControlEventTouchUpInside];

    [self getNearbyDeals];
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
              //  [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
               // [delegate.defaults setValue:@"19.1183" forKey:@"latitude"];
               // [delegate.defaults setValue:@"73.0276" forKey:@"longitude"];
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

-(void)showExhibitions{
    [self.view makeToast:@"Coming Soon"];
    //    ExhibitionListingViewController * result = [self.storyboard instantiateViewControllerWithIdentifier:@"ExhibitionListingViewController"];
    //    [self.navigationController pushViewController:result animated:YES];
    //    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
}

-(void)StaticContent{
    //NSLog(@"type StaticContent .. %@",setType);
    [delegate.defaults setObject:setType forKey:@"staticType"];
    [delegate.defaults synchronize];
    StaticDataViewController * info = [self.storyboard instantiateViewControllerWithIdentifier:@"StaticDataViewController"];
    [self.navigationController pushViewController:info animated:YES];
    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
}

-(void)getNearbyDeals{
   // log_id,store_id,latitude,longitude,radius
   // requestType = @"GetDeals";
     if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%@&longitude=%@&radius=%@&current_latitude=%f&current_longitude=%f&order_by=a.exclusive_discount&order_dir=DESC",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],[delegate.defaults valueForKey:@"radius"],currentLatitude,currentLongitude];
    NSLog(@"messageBody.. %@",messageBody);
    NSLog(@"constant.searchListURL.. %@",commonclass.searchListURL);
    [commonclass sendRequest:self.view mutableDta:dealsdata url:commonclass.searchListURL msgBody:messageBody];
     }else{
         [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }

}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data.. %@",data);
    dispatch_sync(dispatch_get_main_queue(), ^{
        if([[data valueForKey:@"status"]intValue] == 1){
            dealsArr = [data valueForKey:@"items"];
            offerCntLbl.text =[NSString stringWithFormat:@"%lu Offers",(unsigned long)[dealsArr count]];
         [OffersTable reloadData];
        }else if([[data valueForKey:@"status"]intValue] == -1){
            [commonclass logoutFunction];
        }
        else{
            offerCntLbl.text = @"0 Offers around you";
            [self.view makeToast:@"No Offer added yet" duration:4.0 position:CSToastPositionBottom];
        }
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [dealsArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(isexpand==YES) {
        if (selectedIndex == indexPath.section) {
            return 114;
        } else{
            return 40;
        }
        
    } else{
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    cellIdentifier = @"DealsCell";
    cell = (BestDealsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[BestDealsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.shortDealTitleLbl.text = [NSString stringWithFormat:@"%@%% Street treat Offer",[dealsArr[indexPath.section] valueForKey:@"exclusive_discount"]];
    cell.storeNameLbl.text = [NSString stringWithFormat:@"Store : %@",[dealsArr[indexPath.section] valueForKey:@"store_name"]];
    cell.storeCatLbl.text = [NSString stringWithFormat:@"Categories : (%@)",[dealsArr[indexPath.section] valueForKey:@"categories"]];
    cell.longDealTitleLbl.text = [NSString stringWithFormat:@"Address : %@, %@",[dealsArr[indexPath.section] valueForKey:@"address_1"],[dealsArr[indexPath.section] valueForKey:@"address_2"]];
    [cell.ExpandBtn addTarget:self action:@selector(ExpandTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.ExpandBtn.tag = indexPath.section;
    //cell.longDealTitleLbl.text = [NSString stringWithFormat:@" %@",[dealsArr[indexPath.section] valueForKey:@"long_name"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // cell.bucketListLbl.text = [NSString stringWithFormat:@"  %@",[[[[bucketsListArr valueForKey:@"items"] valueForKey:@"buckets"][indexPath.section] valueForKey:@"title"] uppercaseString]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"deals Arr.. %@",dealsArr);
    NSString * storeID = [dealsArr[indexPath.section] valueForKey:@"store_id"];
    [delegate.defaults setValue:storeID forKey:@"store_ID"];
    [delegate.defaults synchronize];
    
    [commonclass Redirect:self.navigationController Identifier:@"DetailViewController"];
    
    
    
}

-(void)ExpandTapped:(UIButton*)sender{
    selectedIndex = (long)sender.tag;
    isexpand = !isexpand;
    if(isexpand == YES){
        [sender setTitle:@"-" forState:UIControlStateNormal];
    }else{
         [sender setTitle:@"+" forState:UIControlStateNormal];
    }
    NSLog(@"sender.tag..%ld",(long)sender.tag);
    path = [NSIndexPath indexPathWithIndex:sender.tag];
    [self tableView:OffersTable heightForRowAtIndexPath:path];
    [OffersTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:sender.tag]] withRowAnimation:UITableViewRowAnimationFade];

}



-(void)backTapped{
    [self.navigationController popViewControllerAnimated:YES];
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
