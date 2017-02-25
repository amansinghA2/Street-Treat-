//
//  ChangePasswordViewController.m
//  VendorApp
//
//  Created by Kamlesh Dubey on 12/6/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController
@synthesize OldPasswordFld,NewPasswordFld,ChangeScroll,getMobile;

- (void)viewDidLoad {
    [super viewDidLoad];
    [delegate.defaults setObject:@"ChangePasswordViewController" forKey:@"internetdisconnect"];
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [commonclass addNavigationBar:self.view];
    backBtn = (UIButton *)[self.view viewWithTag:1111];
    [backBtn addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    //backBtn.hidden = YES;
    UIButton *menubtn = (UIButton *)[self.view viewWithTag:111];
    menubtn.hidden = TRUE;
    UISearchBar *search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
    UIButton *notificationbtn = (UIButton *)[self.view viewWithTag:222];
    notificationbtn.hidden = TRUE;
    
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    current_Loc.hidden = TRUE;

    
    changedata = [[NSMutableData alloc]init];
    
    [self setupChangePassView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

    
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupChangePassView{
    ChangeScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 54, self.view.frame.size.width, self.view.frame.size.height - 54)];
    UILabel * lockIcon = [[UILabel alloc]initWithFrame:CGRectMake(20, ChangeScroll.frame.origin.y - 30, self.view.frame.size.width - 40, 120)];
    lockIcon.font = [UIFont fontWithName:@"fontello" size:120.0];
    lockIcon.textAlignment = NSTextAlignmentCenter;
    lockIcon.textColor = [UIColor lightGrayColor];
    //lockIcon.backgroundColor = [UIColor redColor];
    lockIcon.text = commonclass.forgotIcon;
    
    UILabel * passLbl = [[UILabel alloc]initWithFrame:CGRectMake(lockIcon.frame.origin.x, (lockIcon.frame.origin.y+lockIcon.frame.size.height), lockIcon.frame.size.width, 30)];
    passLbl.text = @"CHANGE PASSWORD";
    passLbl.textAlignment = NSTextAlignmentCenter;
    passLbl.font = [UIFont fontWithName:@"Raleway-Bold" size:15.0];
    passLbl.textColor = [UIColor redColor];
    
    NewPasswordFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(20,passLbl.frame.origin.y+ 90 , lockIcon.frame.size.width, 35)];
    NewPasswordFld.delegate=self;
    NewPasswordFld.placeholder = @"NEW PASSWORD";
    NewPasswordFld.secureTextEntry = YES;
    [commonclass addfeild:ChangeScroll textfeild:NewPasswordFld];
    
    OldPasswordFld = [[RPFloatingPlaceholderTextField alloc]initWithFrame:CGRectMake(20,NewPasswordFld.frame.origin.y+ 45 , lockIcon.frame.size.width, 35)];
    OldPasswordFld.delegate=self;
    OldPasswordFld.returnKeyType = UIReturnKeyNext;
    OldPasswordFld.secureTextEntry = YES;
    OldPasswordFld.placeholder = @"CONFIRM PASSWORD";
    [commonclass addfeild:ChangeScroll textfeild:OldPasswordFld];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelKeyboard)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithKeyboard)]];
    [numberToolbar sizeToFit];
    OldPasswordFld.inputAccessoryView = numberToolbar;
    NewPasswordFld.inputAccessoryView = numberToolbar;
    
    UIButton * changePasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changePasswordBtn.frame = CGRectMake(ChangeScroll.frame.size.width/[commonclass.passSubmitPos floatValue], (NewPasswordFld.frame.origin.y+NewPasswordFld.frame.size.height) + 100, 220, 40);
    changePasswordBtn.titleLabel.font = [UIFont fontWithName:@"Raleway-Bold" size:18.0];
    [changePasswordBtn setTitle:@"CHANGE PASSWORD" forState:UIControlStateNormal];
    changePasswordBtn.titleLabel.textColor = [UIColor whiteColor];
    changePasswordBtn.backgroundColor = [UIColor redColor];
    changePasswordBtn.layer.cornerRadius = 18.0f;
    [changePasswordBtn addTarget:self action:@selector(changeTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [ChangeScroll addSubview:changePasswordBtn];
    [ChangeScroll addSubview:passLbl];
    [ChangeScroll addSubview:lockIcon];
    [self.view addSubview:ChangeScroll];
}

-(void)cancelKeyboard{
    [OldPasswordFld resignFirstResponder];
    [NewPasswordFld resignFirstResponder];
}

-(void)doneWithKeyboard{
    [OldPasswordFld resignFirstResponder];
    [NewPasswordFld resignFirstResponder];
}


- (void)keyboardDidShow:(NSNotification *)notification{
    ChangeScroll.contentSize = CGSizeMake(ChangeScroll.frame.size.width, ChangeScroll.frame.size.height + 200);
}

-(void)keyboardDidHide:(NSNotification *)notification{
    ChangeScroll.contentSize = CGSizeMake(ChangeScroll.frame.size.width, ChangeScroll.frame.size.height);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == OldPasswordFld){
        [NewPasswordFld becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    
    return YES;
}


-(void)changeTapped:(UIButton *)sender{
    [self.view endEditing:YES];
    if(NewPasswordFld.text.length == 0 || OldPasswordFld.text.length == 0){
        [self.view makeToast:@"Please enter proper information"];
    }else if (![NewPasswordFld.text isEqualToString:OldPasswordFld.text]){
        [self.view makeToast:@"Password do not match"];
    }
    else{
        if([[delegate.defaults valueForKey:@"passroute"] isEqualToString:@"FromProfile"]){
            //log_id,password1,password2
             if([commonclass isActiveInternet] == YES){
            NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&password1=%@&password2=%@",[delegate.defaults valueForKey:@"logid"],NewPasswordFld.text,OldPasswordFld.text];
            NSLog(@"messagebody.. %@",messageBody);
            NSLog(@"commonclass.changePasswordURL.. %@",commonclass.changePasswordURL);
            [commonclass sendRequest:self.view mutableDta:changedata url:commonclass.changePassfromProfileURL msgBody:messageBody];
             }else{
                 [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
                 //[self.view makeToast:@"Check your internet connection"];
             }
        }else{
             if([commonclass isActiveInternet] == YES){
            NSString *messageBody = [NSString stringWithFormat:@"token=%@&password=%@",[delegate.defaults valueForKey:@"tokenStr"],NewPasswordFld.text];
            NSLog(@"messagebody.. %@",messageBody);
            NSLog(@"commonclass.changePasswordURL.. %@",commonclass.changePasswordURL);
            [commonclass sendRequest:self.view mutableDta:changedata url:commonclass.changePasswordURL msgBody:messageBody];
             }else{
                 [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
                 //[self.view makeToast:@"Check your internet connection"];
             }
        }
    }
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data.. %@",data);
    dispatch_sync(dispatch_get_main_queue(), ^{
        if(data != NULL){
                if([[data valueForKey:@"status"]intValue] == 1){
                    //[self.view makeToast:@"Your password has been changed sucessfully"];
                   // [self.view make]
                    [self.view makeToast:@"Your password has been changed sucessfully" duration:2.5 position:CSToastPositionBottom];
                    NewPasswordFld.text = nil;
                    OldPasswordFld.text = nil;
                    backBtn.hidden = NO;
                 NSTimer  *timer = [NSTimer scheduledTimerWithTimeInterval: 2.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats:NO];
                    
                    
                }
        }else if([[data valueForKey:@"status"]intValue] == -1){
            [commonclass logoutFunction];
        }else{
            [self.view makeToast:@"Server Error"];
        }
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

-(void) updateCountdown{
    if([[delegate.defaults valueForKey:@"passroute"] isEqualToString:@"FromProfile"]){
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        ViewController * splash = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        UINavigationController *passcodeNavigationController = [[UINavigationController alloc] initWithRootViewController:splash];
        [self presentViewController:passcodeNavigationController animated:YES completion:nil];
    }else{
        LoginViewController * login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:login animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
