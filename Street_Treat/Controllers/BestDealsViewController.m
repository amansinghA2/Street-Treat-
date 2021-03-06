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
    [commonclass setNavigationController:self.navigationController tabBarController:self.tabBarController];
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
    smalldealsArr = [[NSMutableArray alloc]init];
    isexpand = false;
    indexpathArr = [[NSMutableArray alloc]init];
    
    
    if ([delegate.defaults valueForKey:@"user_latitude"] == nil){
        currentLatitude = [[delegate.defaults valueForKey:@"latitude"] floatValue];
        currentLongitude = [[delegate.defaults valueForKey:@"longitude"] floatValue];
    }else{
        currentLatitude = [[delegate.defaults valueForKey:@"user_latitude"] floatValue];
        currentLongitude = [[delegate.defaults valueForKey:@"user_longitude"] floatValue];
        
    }
    
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

-(void)CCKFNavDrawerSelection:(NSInteger)selectedSession selectedRow: (NSInteger) row {
    [commonclass DrawerTapped:selectedSession selectedRow: row];
}

-(void)showExhibitions{
    [self.view makeToast:@"Coming Soon"];
    //    ExhibitionListingViewController * result = [self.storyboard instantiateViewControllerWithIdentifier:@"ExhibitionListingViewController"];
    //    [self.navigationController pushViewController:result animated:YES];
    //    self.tabBarController.tabBar.tintColor = [UIColor lightGrayColor];
}

-(void)getNearbyDeals{
   // log_id,store_id,latitude,longitude,radius
   // requestType = @"GetDeals";
     if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%f&longitude=%f&radius=%@&current_latitude=%@&current_longitude=%@&order_by=a.exclusive_discount&order_dir=DESC",[delegate.defaults valueForKey:@"logid"],currentLatitude,currentLongitude,[delegate.defaults valueForKey:@"radius"],[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"]];
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
            if (dealsArr.count > 10){
            smalldealsArr = [dealsArr subarrayWithRange:NSMakeRange(0, 10)];
            }else{
                smalldealsArr = dealsArr;
            }
            offerCntLbl.text =[NSString stringWithFormat:@"%lu Offers",(unsigned long)[smalldealsArr count]];
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
    return [smalldealsArr count];
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
    cell.shortDealTitleLbl.text = [NSString stringWithFormat:@"%@%% Street treat Offer",[smalldealsArr[indexPath.section] valueForKey:@"exclusive_discount"]];
    cell.storeNameLbl.text = [NSString stringWithFormat:@"Store : %@",[smalldealsArr[indexPath.section] valueForKey:@"store_name"]];
    cell.storeCatLbl.text = [NSString stringWithFormat:@"Categories : (%@)",[smalldealsArr[indexPath.section] valueForKey:@"categories"]];
    cell.longDealTitleLbl.text = [NSString stringWithFormat:@"Address : %@, %@",[smalldealsArr[indexPath.section] valueForKey:@"address_1"],[dealsArr[indexPath.section] valueForKey:@"address_2"]];
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
