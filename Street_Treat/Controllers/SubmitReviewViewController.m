//
//  SubmitReviewViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/5/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "SubmitReviewViewController.h"

@interface SubmitReviewViewController (){
    UIView *contentView;
    UPStackMenu *stack;
}

@end

@implementation SubmitReviewViewController
@synthesize feedbackBtns,feedbackTxtView,FedbacklblsArr,feedbackScroll;

-(void)viewWillAppear:(BOOL)animated{
    [delegate.defaults setObject:@"SubmitReviewViewController" forKey:@"internetdisconnect"];
    feedbackTxtView.layer.borderWidth = 1.0f;
    feedbackTxtView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    for(UIButton * btn in feedbackBtns){
        [btn setTitle:commonclass.radioemptyIcon forState:UIControlStateNormal];
    }
    
    [feedbackBtns[0] setTitle:commonclass.radiofilledIcon forState:UIControlStateNormal];
    
    _feedbacktypesArr = [[NSArray alloc]initWithObjects:@"Must Visit",@"Recommended",@"Worth Exploring",@"Needs Improvement",@"Not Recommended", nil];
    ratings = 5;
    
     feedbackBtns = [feedbackBtns sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:YES]]];
    for (UILabel *lbl in FedbacklblsArr){
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage:)];
        tapRecognizer.delegate = self;
        [lbl addGestureRecognizer:tapRecognizer];
        lbl.userInteractionEnabled = YES;
    }
    
    _storeNameLbl.text = [delegate.defaults valueForKey:@"Store_Name"];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [contentView removeFromSuperview];
    [stack removeFromSuperview];
    [flyoutView removeFromSuperview];
}

-(void)selectImage:(UIGestureRecognizer *)gesture{
    [self feedbackTapped:feedbackBtns[gesture.view.tag]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    [commonclass addNavigationBar:self.view];
    addReviewforStoreData = [[NSMutableData alloc]init];
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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

    
    UIToolbar* numberToolbarTxtFlds = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbarTxtFlds.barStyle = UIBarStyleBlackTranslucent;
    numberToolbarTxtFlds.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelKeyboard)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithKeyboard)]];
    [numberToolbarTxtFlds sizeToFit];
    feedbackTxtView.inputAccessoryView = numberToolbarTxtFlds;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    _mstVisitStarsLbl.text = commonclass.fivestarIcon;
    _rcmdStarsLbl.text = commonclass.fourstarIcon;
    _worthExploringStarsLbl.text = commonclass.threestarIcon;
    _needsImprovementStarsLbl.text = commonclass.twostarIcon;
    _notRecommendedStarsLbl.text = commonclass.starIcon;
}


-(void)viewDidAppear:(BOOL)animated{
    
    [self setUpstackMenu];
}

-(void)cancelKeyboard{
    [feedbackTxtView resignFirstResponder];
}

-(void)doneWithKeyboard{
    [feedbackTxtView resignFirstResponder];
}

- (void)keyboardDidShow:(NSNotification *)notification{
    feedbackScroll.contentSize = CGSizeMake(feedbackScroll.frame.size.width, feedbackScroll.frame.size.height + 230);
}

-(void)keyboardDidHide:(NSNotification *)notification{
    feedbackScroll.contentSize = CGSizeMake(feedbackScroll.frame.size.width, feedbackScroll.frame.size.height);
}


-(void)backTapped{
    [delegate.defaults setValue:@"" forKey:@"navigateFromSubmitReview"];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text = @"";
    textView.textColor = [UIColor darkGrayColor];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if(textView.text.length>0){
        _feedbackString = textView.text;
        if([_feedbackString isEqualToString:@" Please provide your valuable feedback"]){
            _feedbackString = @"";
        }else{
            _feedbackString = textView.text;
        }
    }else{
        textView.text = @" Please provide your valuable feedback";
        textView.textColor = [UIColor lightGrayColor];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (IBAction)feedbackTapped:(UIButton *)sender {
    NSLog(@"text  %@",[_feedbacktypesArr objectAtIndex:sender.tag]);
    ratings = sender.tag;
    for(UIButton * btn in feedbackBtns){
        [btn setTitle:commonclass.radioemptyIcon forState:UIControlStateNormal];
    }
    [sender setTitle:commonclass.radiofilledIcon forState:UIControlStateNormal];
    
}
- (IBAction)submitTapped:(id)sender {
    [self.view endEditing:YES];
    if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%@&ratings=%ld&comments=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"Store_ID"],ratings,_feedbackString];
    NSLog(@"message body... %@",[delegate.defaults valueForKey:@"Store_ID"]);
    NSLog(@"review URL body... %@",commonclass.addReviewsforStoreURL);
    [commonclass sendRequest:self.view mutableDta:addReviewforStoreData url:commonclass.addReviewsforStoreURL msgBody:messageBody];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data... %@",data);
    dispatch_sync(dispatch_get_main_queue(), ^{
        if(data != NULL){
            if([[data valueForKey:@"status"]intValue] == 1){
                [self.navigationController popViewControllerAnimated:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
                feedbackTxtView.text = nil;
            }else if([[data valueForKey:@"status"]intValue] == -1){
                [commonclass logoutFunction];
            }
        }
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
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

-(void)notificationsTapped{
    NotificationsViewController * notifications = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    [self presentViewController:notifications animated:YES completion:nil];
}


//-(void)CCKFNavDrawerSelection:(NSInteger)selectedSession selectedRow: (NSInteger) row {
//    [constant DrawerTapped:selectedSession selectedRow: row];
//}

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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
