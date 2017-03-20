//
//  CCKFNavDrawer.m
//  CCKFNavDrawer
//
//  Created by calvin on 23/1/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import "CCKFNavDrawer.h"
#import "DrawerView.h"
//#import "DTCustomColoredAccessory.h"
#import "MenuViewCell.h"

#define SHAWDOW_ALPHA 0.5
#define MENU_DURATION 0.3
#define MENU_TRIGGER_VELOCITY 350

@interface CCKFNavDrawer ()

@property (nonatomic) BOOL isOpen;
@property (nonatomic) float meunHeight;
@property (nonatomic) float menuWidth;
@property (nonatomic) CGRect outFrame;
@property (nonatomic) CGRect inFrame;
@property (strong, nonatomic) UIView *shawdowView;
@property (strong, nonatomic) DrawerView *drawerView;

@end

@implementation CCKFNavDrawer
//id json;
@synthesize searchStoreIcon,menIcon,womenIcon,childrenIcon,exhibitionsIcon,aboutUsIcon,news_eventsIcon,terms_conditionsIcon,contactUsIcon,faqsIcon,privacyIcon,editProfileIcon,rateAppIcon,helpIcon,logoutIcon;

#pragma mark - VC lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    searchStoreIcon = @"\ue072";
    menIcon = @"\ue054";
    womenIcon = @"\ue084";
    childrenIcon = @"\ue025";
    exhibitionsIcon = @"\ue036";
    aboutUsIcon = @"\ue009";
    news_eventsIcon = @"\ue064";
    terms_conditionsIcon = @"\ue078";
    faqsIcon = @"\ue080";
    privacyIcon = @"\ue039";
    contactUsIcon = @"\ue027";
    editProfileIcon = @"\ue034";
    rateAppIcon = @"\ue068";
    helpIcon = @"\ue044";
    logoutIcon = @"\ue052";
    
    isExpandable = false;
    selectedIndex = [[NSIndexPath alloc]init];
    //[self setUpDrawer];
    /*menuNamesArray = [[NSArray alloc]initWithObjects:@"EARLY BIRD SYSTEM",@"KPU LOYALTY SYSTEM",@"WEBHOLD",@"TRACK LIST",@"MY OFFER",@"PURCHASES ACCOUNT",@"DEMAND/CPO",@"MY VIEW REQUEST",@"EDIT PROFILE",@"CHANGE PASSWORD",@"", nil];
     
     menuImagesArray = [[NSArray alloc]initWithObjects:@"EBS.png",@"Loyalty_Sys.png",@"Menu_Webhold.png",@"Menu_Tracklist.png",@"Menu_MyOffer.png",@"Purchase_Account.png",@"Demand_CPO.png",@"MyView_Request.png",@"Edit_Profile.png",@"Change_Password.png",@"", nil];*/
    //commonclass = [[Common alloc]init];
    subMenuArray = [[NSMutableArray alloc]initWithObjects:@"hello", nil];
    menuNamesArray = [[NSArray alloc]initWithObjects:@"Search Stores",@"Stores for Men",@"Stores for Women",@"Stores for Kids",@"About Us",@"News & Events ",@"Terms & Conditions",@"FAQs",@"Privacy Policy",@"Contact Us",@"Edit Profile",@"Help",@"Rate App",@"Logout",nil];
    
    menuImagesArray = [[NSArray alloc]initWithObjects:searchStoreIcon,menIcon,womenIcon,childrenIcon,aboutUsIcon,news_eventsIcon,terms_conditionsIcon,faqsIcon,privacyIcon,contactUsIcon,editProfileIcon,helpIcon,rateAppIcon,logoutIcon, nil];
    
    earlyBirdArray = [[NSArray alloc]initWithObjects:@"Day 1",@"Day 2",@"Day 3",@"Coming Soon", nil];
    
    earlyBirdImagesArray = [[NSArray alloc]initWithObjects:@"Menu_Day.png",@"Menu_Day.png",@"Menu_Day.png",@"Menu_ComingSoon.png", nil];
    
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
    
}

#pragma mark - push & pop

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    
    [self.pan_gr setEnabled:NO];// disable gesture in next vc
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    
    if ([self.viewControllers count]==1){ // enable gesture in root vc
        [self.pan_gr setEnabled:YES];
    }
    return vc;
}

#pragma mark - drawer

- (void)setUpDrawer{
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.isOpen = NO;
    ht = 0;
    ht = [[UIScreen mainScreen] bounds].size.height;
    if (!self.drawerView) {
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            
            self.drawerView = [[[NSBundle mainBundle] loadNibNamed:@"DrawerView" owner:self options:nil] objectAtIndex:0];
            self.drawerView.profilePic.layer.cornerRadius = self.drawerView.profilePic.frame.size.height/2;
            self.drawerView.profilePic.clipsToBounds = YES;
            //self.meunHeight = self.drawerView.frame.size.height;
            self.drawerView.NameLbl.text = [NSString stringWithFormat:@"  Hi, %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"usr_name"]];
            self.drawerView.phoneNoLbl.text = [delegate.defaults valueForKey:@"mobile"];
            [self.drawerView.NameLbl setShadowColor:[UIColor lightGrayColor]];
            [self.drawerView.NameLbl setShadowOffset:CGSizeMake(0, -1)];
            [self.drawerView.phoneNoLbl setShadowColor:[UIColor lightGrayColor]];
            [self.drawerView.phoneNoLbl setShadowOffset:CGSizeMake(0, -1)];
            [delegate.defaults synchronize];
            //            self.drawerView.LoyaltyLvlLbl.text = [delegate.defaults valueForKey:@"LoyaltyLvl"];
            //            self.drawerView.StatusLbl.text = [NSString stringWithFormat:@"365 days your purchase $%@. More to avail next loyalty level benifits $%@.",[delegate.defaults valueForKey:@"loyaltyVlu"],[delegate.defaults valueForKey:@"loyaltyDiff"]];
            //        [NameLbl setText:[NSString stringWithFormat:@"  Hi, %@",[delegate.defaults valueForKey:@"Name"]]];
            //        TermsLbl.text = [delegate.defaults valueForKey:@"Terms"];
            //        LoyaltyLvlLbl.text = [delegate.defaults valueForKey:@"LoyaltyLvl"];
            //        StatusLbl.text = [NSString stringWithFormat:@"365 days your purchase $%@. More to avail next loyalty level benifits $%@.",[delegate.defaults valueForKey:@"loyaltyVlu"],[delegate.defaults valueForKey:@"loyaltyDiff"]];
            
            self.meunHeight = ht;
            self.menuWidth = self.drawerView.frame.size.width;
            
            self.shawdowView = [[UIView alloc] initWithFrame:self.view.frame];    // drawer shawdow and assign its gesture
            self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
            self.shawdowView.hidden = YES;
            
            UITapGestureRecognizer *tapIt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnShawdow:)];
            [self.shawdowView addGestureRecognizer:tapIt];
            self.shawdowView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.view addSubview:self.shawdowView];
            if(ht == 480){
                self.outFrame = CGRectMake(self.menuWidth+120,0,self.menuWidth+100,self.meunHeight);
                temp = self.outFrame;
                temp.size.height = temp.size.height-20;
                self.drawerView.frame = temp;
                
                CGRect tempTable = self.drawerView.drawerTableView.frame;
                tempTable.size.height = tempTable.size.height;
                self.drawerView.drawerTableView.frame = tempTable;
                self.inFrame = CGRectMake (self.menuWidth-120,0,self.menuWidth+100,self.drawerView.frame.size.height);
            }
            if(ht == 568){
                self.outFrame = CGRectMake(self.menuWidth+120,0,self.menuWidth+100,self.meunHeight);
                temp = self.outFrame;
                temp.size.height = temp.size.height;
                self.drawerView.frame = temp;
                
                CGRect tempTable = self.drawerView.drawerTableView.frame;
                tempTable.size.height = tempTable.size.height;
                self.drawerView.drawerTableView.frame = tempTable;
                self.inFrame = CGRectMake (self.menuWidth-120,0,self.menuWidth+100,self.drawerView.frame.size.height);
            }
            else if(ht == 667){
                self.outFrame = CGRectMake(self.menuWidth+180,0,self.menuWidth,self.meunHeight);
                temp = self.outFrame;
                temp.size.height = temp.size.height;
                self.drawerView.frame = temp;
                
                CGRect tempTable = self.drawerView.drawerTableView.frame;
                tempTable.size.height = tempTable.size.height;
                self.drawerView.drawerTableView.frame = tempTable;
                self.inFrame = CGRectMake (self.menuWidth-75,0,self.menuWidth+100,self.drawerView.frame.size.height);
            }
            
            else if(ht == 736){
                self.outFrame = CGRectMake(self.menuWidth+220,0,self.menuWidth,self.meunHeight);
                temp = self.outFrame;
                temp.size.height = temp.size.height;
                self.drawerView.frame = temp;
                
                CGRect tempTable = self.drawerView.drawerTableView.frame;
                tempTable.size.height = tempTable.size.height;
                self.drawerView.drawerTableView.frame = tempTable;
                self.inFrame = CGRectMake (self.menuWidth-30,0,self.menuWidth+100,self.drawerView.frame.size.height);
            }
            
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.drawerView];
        }else{
            self.drawerView = [[[NSBundle mainBundle] loadNibNamed:@"DrawerView_iPad" owner:self options:nil] objectAtIndex:0];
            self.drawerView.profilePic.layer.cornerRadius = self.drawerView.profilePic.frame.size.height/2;
            self.drawerView.profilePic.clipsToBounds = YES;
            self.drawerView.NameLbl.text = [NSString stringWithFormat:@"  Hi, %@",[delegate.defaults valueForKey:@"usr_name"]];
            self.drawerView.phoneNoLbl.text = [delegate.defaults valueForKey:@"mobile"];
            [self.drawerView.NameLbl setShadowColor:[UIColor lightGrayColor]];
            [self.drawerView.NameLbl setShadowOffset:CGSizeMake(0, -1)];
            [self.drawerView.phoneNoLbl setShadowColor:[UIColor lightGrayColor]];
            [self.drawerView.phoneNoLbl setShadowOffset:CGSizeMake(0, -1)];
            
            //self.meunHeight = self.drawerView.frame.size.height;
            self.meunHeight = ht;
            self.menuWidth = self.drawerView.frame.size.width;
            
            self.shawdowView = [[UIView alloc] initWithFrame:self.view.frame];    // drawer shawdow and assign its gesture
            self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
            self.shawdowView.hidden = YES;
            
            UITapGestureRecognizer *tapIt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnShawdow:)];
            [self.shawdowView addGestureRecognizer:tapIt];
            self.shawdowView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.view addSubview:self.shawdowView];
            
            self.outFrame = CGRectMake(self.menuWidth+425,0,self.menuWidth,self.view.frame.size.height);
            temp = self.outFrame;
            temp.size.height = temp.size.height;
            self.drawerView.frame = temp;
            
            CGRect tempTable = self.drawerView.drawerTableView.frame;
            tempTable.size.height = tempTable.size.height;
            self.drawerView.drawerTableView.frame = tempTable;
            self.inFrame = CGRectMake (self.menuWidth+70,0,self.menuWidth,self.view.frame.size.height);
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.drawerView];
        }
    }else{
        //           NSLog(@"name.. %@",[delegate.defaults valueForKey:@"Name"]);
        //         self.drawerView.NameLbl.text = [NSString stringWithFormat:@"  Hi, %@",[delegate.defaults valueForKey:@"Name"]];
        //        self.drawerView.TermsLbl.text = [delegate.defaults valueForKey:@"Terms"];
        //        self.drawerView.LoyaltyLvlLbl.text = [delegate.defaults valueForKey:@"LoyaltyLvl"];
        //        self.drawerView.StatusLbl.text = [NSString stringWithFormat:@"365 days your purchase $%@. More to avail next loyalty level benifits $%@.",[delegate.defaults valueForKey:@"loyaltyVlu"],[delegate.defaults valueForKey:@"loyaltyDiff"]];
    }
    
    //    }else{
    //        self.drawerView = [[[NSBundle mainBundle] loadNibNamed:@"DrawerView" owner:self options:nil] objectAtIndex:0];
    //        self.outFrame = CGRectMake(self.menuWidth + 768,45,self.menuWidth,self.meunHeight);
    //
    //        [self.view addSubview:self.drawerView];
    // }
    
    /*else{
     self.outFrame = CGRectMake(self.menuWidth+175,0,self.menuWidth+100,self.meunHeight);
     temp = self.outFrame;
     temp.size.height = temp.size.height;
     self.drawerView.frame = temp;
     
     CGRect tempTable = self.drawerView.drawerTableView.frame;
     tempTable.size.height = tempTable.size.height;
     self.drawerView.drawerTableView.frame = tempTable;
     self.inFrame = CGRectMake (self.menuWidth-175,0,self.menuWidth+100,self.drawerView.frame.size.height);
     }
     */
    
    
    
    // drawer list
    [self.drawerView.drawerTableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)]; // statuesBarHeight+navBarHeight
    self.drawerView.drawerTableView.dataSource = self;
    self.drawerView.drawerTableView.delegate = self;
    
    self.pan_gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveDrawer:)];
    self.pan_gr.maximumNumberOfTouches = 1;
    self.pan_gr.minimumNumberOfTouches = 1;
    [self.view addGestureRecognizer:self.pan_gr];
    
    //[self.view bringSubviewToFront:self.navigationBar];
    
}

- (void)drawerToggle
{
    if (!self.isOpen) {
        [self setUpDrawer];
        [self openNavigationDrawer];
    }else{
        [self closeNavigationDrawer];
    }
}

//- (void)Logout{
//
//}

#pragma open and close action

- (void)openNavigationDrawer{
    //    NSLog(@"open x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*abs(self.drawerView.center.x)+MENU_DURATION/2; // y=mx+c
    
    // shawdow
    self.shawdowView.hidden = NO;
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:SHAWDOW_ALPHA];
                     }
                     completion:nil];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         self.drawerView.frame = self.inFrame;
                     }
                     completion:nil];
    
    self.isOpen= YES;
}

- (void)closeNavigationDrawer{
    //    NSLog(@"close x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*abs(self.drawerView.center.x)+MENU_DURATION/2; // y=mx+c
    
    // shawdow
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         self.shawdowView.hidden = YES;
                     }];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //self.drawerView.frame = self.outFrame;
                         self.drawerView.frame = temp;
                     }
                     completion:nil];
    self.isOpen= NO;
}

#pragma gestures

- (void)tapOnShawdow:(UITapGestureRecognizer *)recognizer {
    [self closeNavigationDrawer];
}

-(void)moveDrawer:(UIPanGestureRecognizer *)recognizer
{
    //    ViewController * view = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    //    if([NSStringFromClass([view class]) isEqualToString:@"ViewController"]){
    //
    //    }else{
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)recognizer velocityInView:self.view];
    //    NSLog(@"velocity x=%f",velocity.x);
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateBegan) {
        //        NSLog(@"start");
        if ( velocity.x > MENU_TRIGGER_VELOCITY && !self.isOpen) {
            [self openNavigationDrawer];
        }else if (velocity.x < -MENU_TRIGGER_VELOCITY && self.isOpen) {
            [self closeNavigationDrawer];
        }
        // }
        
        if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateChanged) {
            //        NSLog(@"changing");
            float movingx = self.drawerView.center.x + translation.x;
            if ( movingx > -self.menuWidth/2 && movingx < self.menuWidth/2){
                
                self.drawerView.center = CGPointMake(movingx, self.drawerView.center.y);
                [recognizer setTranslation:CGPointMake(0,0) inView:self.view];
                
                float changingAlpha = SHAWDOW_ALPHA/self.menuWidth*movingx+SHAWDOW_ALPHA/2; // y=mx+c
                self.shawdowView.hidden = NO;
                self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:changingAlpha];
            }
        }
        
        if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateEnded) {
            //        NSLog(@"end");
            if (self.drawerView.center.x>0){
                [self openNavigationDrawer];
            }else if (self.drawerView.center.x<0){
                [self closeNavigationDrawer];
            }
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //return [[json valueForKey:@"Categories"] count];
    return [menuNamesArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (selectedIndex.section == section) {
        return [subMenuArray count] + 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

- (void)AccessoryType:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if ([expandedSections containsIndex:indexPath.section])
        cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor whiteColor] type:DTCustomColoredAccessoryTypeUp];
    else
        cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor whiteColor] type:DTCustomColoredAccessoryTypeDown];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    MenuViewCell *cell = (MenuViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }else{
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MenuCell_iPad" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",[menuNamesArray objectAtIndex:indexPath.section]];
        cell.thumbImg.text = [menuImagesArray objectAtIndex:indexPath.section];
    }
    if (indexPath.section == 1 ) {
        if (indexPath.row == 0){
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.menuWidth, 5, 50, 30)];
            if (isExpandable == true && selectedIndex.section == 1){
                [button setTitle:@"-" forState:UIControlStateNormal];
            }else{
                [button setTitle:@"+" forState:UIControlStateNormal];
            }
            [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = indexPath.section;
            [cell addSubview:button];
        }else{
            cell.nameLabel.text = [NSString stringWithFormat:@" ->  %@",[subMenuArray objectAtIndex:indexPath.row - 1]];
            cell.thumbImg.text = @"";
        }
    }else if (indexPath.section == 2 ) {
        if (indexPath.row == 0){
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.menuWidth, 5, 50, 30)];
            if (isExpandable == true && selectedIndex.section == 2){
                [button setTitle:@"-" forState:UIControlStateNormal];
            }else{
                [button setTitle:@"+" forState:UIControlStateNormal];
            }
            [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = indexPath.section;
            [cell addSubview:button];
        }else{
            cell.nameLabel.text = [NSString stringWithFormat:@" ->  %@",[subMenuArray objectAtIndex:indexPath.row - 1]];
            cell.thumbImg.text = @"";
        }
    }else if (indexPath.section == 3) {
        if (indexPath.row == 0){
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.menuWidth, 5, 50, 30)];
            if (isExpandable == true && selectedIndex.section == 3 ){
                [button setTitle:@"-" forState:UIControlStateNormal];
            }else{
                [button setTitle:@"+" forState:UIControlStateNormal];
            }
            [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = indexPath.section;
            [cell addSubview:button];
        }else{
            cell.nameLabel.text = [NSString stringWithFormat:@" ->  %@",[subMenuArray objectAtIndex:indexPath.row - 1]];
            cell.thumbImg.text = @"";
        }
    }
    
    [cell setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:23.0f/255.0f blue:68.0f/255.0f alpha:1.0f]];
    return cell;
}

-(void)buttonTapped:(UIButton *)sender{
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:self.drawerView.drawerTableView];
    NSIndexPath *tappedIP = [self.drawerView.drawerTableView indexPathForRowAtPoint:buttonPosition];
    selectedIndex = tappedIP;
    
    isExpandable = !isExpandable;
    
    subMenuArray = nil;
    
    
    if (tappedIP.section == 1){
        if (isExpandable == true) {
            subMenuArray =  [delegate.defaults objectForKey:@"mensArray"];
        }
        
    }else if(tappedIP.section == 2){
        if (isExpandable == true) {
            
            subMenuArray =  [delegate.defaults objectForKey:@"womensArray"];
            
        }
    }else if(tappedIP.section == 3){
        
        if (isExpandable == true) {
            subMenuArray =  [delegate.defaults objectForKey:@"childrenArray"];
        }
    }else{
        
    }
    [self.drawerView.drawerTableView reloadData];
    
}

- (void)buttonPressedAction:(id)sender
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    // [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [self closeNavigationDrawer];
    [self.CCKFNavDrawerDelegate Drawer_Logout];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [delegate.defaults setObject:@"Section" forKey:@"drawerRoute"];
    [delegate.defaults synchronize];
    NSInteger row = indexPath.row - 1;
    [self.CCKFNavDrawerDelegate CCKFNavDrawerSelection:indexPath.section selectedRow: row];
    [expandedSections removeAllIndexes];
    [tableView reloadData];
    [self closeNavigationDrawer];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


@end
