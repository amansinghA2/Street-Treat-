//
//  ReportErrorViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/5/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "ReportErrorViewController.h"

@interface UITextView(MYTextView)

@end

@implementation UITextView (MYTextView)
- (void)_firstBaselineOffsetFromTop {
    
}

- (void)_baselineOffsetFromBottom {
    
}

@end

@interface ReportErrorViewController (){
    UIView *contentView;
    UPStackMenu *stack;
}

@end

@implementation ReportErrorViewController
@synthesize CheckboxBtns,submitBtn,reportTxtView,reportString,otherBtn,reportScroll,ErrTypesLbls;

-(void)viewWillAppear:(BOOL)animated{
    otherBtn.hidden = true;
    [delegate.defaults setObject:@"ReportErrorViewController" forKey:@"internetdisconnect"];
    self.navigationItem.hidesBackButton = YES;
    reportTxtView.layer.borderWidth = 1.0f;
    reportTxtView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    for(UIButton * btn in CheckboxBtns){
   //[btn setTitle:constant.checkboxemptyIcon forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        btn.layer.borderWidth = 1.0;
        btn.layer.cornerRadius = 2.0;
    }
//    [otherBtn setTitle:constant.checkboxemptyIcon forState:UIControlStateNormal];
    
    _errortypesArr = [[NSArray alloc]initWithObjects:@"Contact Issue",@"Address Issue",@"Store Closed",@"Amenities",@"Wrong Timings",@"Discount Issue", nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    constant = [[Common alloc]init];
    constant.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [constant addNavigationBar:self.view];
    reportData = [[NSMutableData alloc]init];
    selectedErrors = [[NSMutableArray alloc]init];
    CheckboxBtns = [CheckboxBtns sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:YES]]];
    
    
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
    reportTxtView.inputAccessoryView = numberToolbarTxtFlds;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    for (UILabel *lbl in ErrTypesLbls){
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage:)];
        tapRecognizer.delegate = self;
        [lbl addGestureRecognizer:tapRecognizer];
         lbl.userInteractionEnabled = YES;
    }
    
    _storeNameLbl.text = [delegate.defaults valueForKey:@"Store_Name"];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self setUpstackMenu];
}

-(void)viewDidDisappear:(BOOL)animated{
    [contentView removeFromSuperview];
    [stack removeFromSuperview];
    [flyoutView removeFromSuperview];
}


-(void)selectImage:(UIGestureRecognizer *)gesture{
    [self checkboxTapped:CheckboxBtns[gesture.view.tag]];
}

- (void)keyboardDidShow:(NSNotification *)notification{
    reportScroll.contentSize = CGSizeMake(reportScroll.frame.size.width, reportScroll.frame.size.height + 230);
}

-(void)keyboardDidHide:(NSNotification *)notification{
    reportScroll.contentSize = CGSizeMake(reportScroll.frame.size.width, reportScroll.frame.size.height);
}

-(void)cancelKeyboard{
    [self.view endEditing:YES];
}

-(void)doneWithKeyboard{
    [self.view endEditing:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text = @"";
    textView.textColor = [UIColor darkGrayColor];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if(textView.text.length>0){
        reportString = textView.text;
        if([reportString isEqualToString:@" Please specify error"]){
            reportString = @"";
        }else{
            reportString = textView.text;
           // [selectedErrors addObject:reportString];
        }
    }else{
        textView.text = @" Please specify error";
        textView.textColor = [UIColor lightGrayColor];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


-(void)backTapped{
    [delegate.defaults setValue:@"" forKey:@"navigateFromReport"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitTapped:(id)sender {
    [self.view endEditing:YES];
    NSLog(@"Selected Errors.. %@",selectedErrors);
    if(reportTxtView.text == nil || [reportTxtView.text isEqualToString:@" Please specify error"] || [selectedErrors count] == 0){
        [self.view makeToast:@"Please specify error"];
    }else{
         if([constant isActiveInternet] == YES){
    NSString * errstr = [selectedErrors componentsJoinedByString:@","];
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%@&reason=%@&message=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"Store_ID"],errstr,reportTxtView.text];
        NSLog(@"body.. %@",messageBody);
        NSLog(@"url.. %@",constant.reportErrorURL);
    [constant sendRequest:self.view mutableDta:reportData url:constant.reportErrorURL msgBody:messageBody];
    }else{
             [constant Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
             //[self.view makeToast:@"Check your internet connection"];
        }
    }
}

- (IBAction)otherTapped:(UIButton *)sender {
    sender.highlighted = NO;
    sender.selected  = ! sender.selected;
    if (sender.selected){
//        [sender setBackgroundImage:[UIImage imageNamed:@"%@",] forState:UIControlStateNormal]
        [selectedErrors addObject:[_errortypesArr objectAtIndex:sender.tag]];
    }else{
//        [sender setTitle:constant.checkboxemptyIcon forState:UIControlStateNormal];
        [selectedErrors removeObject:[_errortypesArr objectAtIndex:sender.tag]];
    }
}
- (IBAction)checkboxTapped:(UIButton *)sender {
    sender.highlighted = NO;
    sender.selected  = ! sender.selected;
    if (sender.selected){
        [sender setBackgroundImage:[UIImage imageNamed:@"checkmark_icon.jpg"] forState:UIControlStateNormal];
        //[sender setTitle:constant.checkboxemptyIcon forState:UIControlStateNormal];
        [selectedErrors addObject:[_errortypesArr objectAtIndex:sender.tag]];
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        // [sender setTitle:constant.checkboxfilledIcon forState:UIControlStateNormal];
         [selectedErrors removeObject:[_errortypesArr objectAtIndex:sender.tag]];
    }
    // [sender setShowsTouchWhenHighlighted:NO];
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data.. %@",data);
    dispatch_sync(dispatch_get_main_queue(), ^{
       if([[data valueForKey:@"status"]intValue] == 1){
            [self.navigationController popViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
//           for(UIButton * btn in CheckboxBtns){
//               [btn setTitle:constant.checkboxemptyIcon forState:UIControlStateNormal];
//           }
           reportTxtView.text = nil;
       }else if([[data valueForKey:@"status"]intValue] == -1){
           [constant logoutFunction];
       }else{
           [self.view makeToast:[data valueForKey:@"message"]];
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


-(void)CCKFNavDrawerSelection:(NSInteger)selectedSession selectedRow: (NSInteger) row {
    [constant DrawerTapped:selectedSession selectedRow: row];
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
        [constant Redirect:self.navigationController Identifier:@"ResultsViewController"];
    }else if(index == 1){
        [constant Redirect:self.navigationController Identifier:@"ProfileViewController"];
    }else if (index == 2){
        
    }
    [stack closeStack];
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //    [alert show];
}

@end
