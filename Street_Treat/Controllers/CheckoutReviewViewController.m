//
//  CheckoutReviewViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 10/12/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "CheckoutReviewViewController.h"

@implementation CheckoutReviewViewController
@synthesize CategorySelect,priceSelect,salesmanSelect,AppealSelect,trailRoomSelect,overallShoppingLbl;

-(void)viewDidLoad{
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    _feedBackTextView.layer.borderWidth = 1.0f;
    _feedBackTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _feedBackTextView.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    UIToolbar* numberToolbarTxtFlds = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbarTxtFlds.barStyle = UIBarStyleBlackTranslucent;
    numberToolbarTxtFlds.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelKeyboard)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithKeyboard)]];
    [numberToolbarTxtFlds sizeToFit];
    _feedBackTextView.inputAccessoryView = numberToolbarTxtFlds;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    parentsData = [[NSMutableData alloc]init];
    ratingsVal = 0;
    categorySelString = @"Good";
    AppealSelectString = @"Good";
    trailRoomSelectString = @"Good";
    salesmanSelectString = @"Good";
}


-(void)cancelKeyboard{
    [_feedBackTextView resignFirstResponder];
}

-(void)doneWithKeyboard{
    [_feedBackTextView resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated{
    _storeNameLabel.text = [delegate.defaults valueForKey:@"namestore"];
}

- (IBAction)categoryChanged:(id)sender {
    
    if (CategorySelect.selectedSegmentIndex == 0){
        categorySelString = @"Good";
    }else if(CategorySelect.selectedSegmentIndex == 1){
        categorySelString = @"Moderate";
    }else{
        categorySelString = @"Bad";
    }
    
}


-(void)dismissKeyboard
{
    [self.view endEditing:YES];
    [_feedBackTextView resignFirstResponder];
}

- (IBAction)submitTapped:(id)sender {
    if ([_pricetTextfield.text isEqualToString:@""]){
        [self.view makeToast:@"Price field cannot be left blank"];
    }else if([_feedBackTextView.text isEqualToString:@""]){
        [self.view makeToast:@"Feedback cannot be left blank"];
    }else{
        NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%@&ratings=%f&comments=%@&category_of_goods=%@&approximate_price=%@&salesman_review=%@&store_appeal=%@&trial_room=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"idstore"], ratingsVal, _feedBackTextView.text , categorySelString , _pricetTextfield.text ,salesmanSelectString ,AppealSelectString ,trailRoomSelectString];
        NSLog(@"body.. %@",messageBody);
        NSLog(@"commonclass.LoginURL.. %@",commonclass.shoppingReviewUrl);
        [commonclass sendRequest:self.view mutableDta:parentsData url:commonclass.shoppingReviewUrl msgBody:messageBody];
    }
}

-(void)sendResponse:(Common *)response data:(NSMutableArray *)data indicator:(UIActivityIndicatorView *)indicator{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[data valueForKey:@"status"]intValue] == 1){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController *splash = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            UINavigationController *passcodeNavigationController = [[UINavigationController alloc] initWithRootViewController:splash];
            [self presentViewController:passcodeNavigationController animated:YES completion:nil];
            
//            DashboardViewController *securityCheck = [storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
//            [self presentViewController:securityCheck animated:YES completion:nil];
          //  [commonclass Redirect:self.navigationController Identifier:@"DashboardViewController"];
        }else if([[data valueForKey:@"status"]intValue] == -1){
            [commonclass logoutFunction];
        }else{
            
        }
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
    
}

- (IBAction)closeTapped:(id)sender {
    [self.view makeToast:@"Review is required"];
}

- (IBAction)ratingsAction:(id)sender {
    
    float increment = 1.0;
    float newValue = _sliderOutlet.value /increment;
    _sliderOutlet.value = floor(newValue) * increment;
    ratingsVal = _sliderOutlet.value;
  _ratingsMaxLbl.text = [NSString stringWithFormat:@"%.0f/5",_sliderOutlet.value];
    
}

//- (IBAction)priceChanged:(id)sender {
//    
////    if (priceSelect.selectedSegmentIndex == 0){
//////        _pricetTextfield.text =
////    }else if(priceSelect.selectedSegmentIndex == 1){
////        
////    }else{
////        
////    }
//}

- (IBAction)salesmanChanged:(id)sender {
    
    if (salesmanSelect.selectedSegmentIndex == 0){
        salesmanSelectString = @"Good";
    }else if(salesmanSelect.selectedSegmentIndex == 1){
        salesmanSelectString = @"Moderate";
    }else{
        salesmanSelectString = @"Bad";
    }
}
- (IBAction)AppealChanged:(id)sender {
    
    if (AppealSelect.selectedSegmentIndex == 0){
        AppealSelectString = @"Good";
    }else if(AppealSelect.selectedSegmentIndex == 1){
        AppealSelectString = @"Moderate";
    }else{
        AppealSelectString = @"Bad";
    }
    
    
}
- (IBAction)trailRoomChanged:(id)sender {
    
    if (trailRoomSelect.selectedSegmentIndex == 0){
        trailRoomSelectString = @"Good";
    }else if(trailRoomSelect.selectedSegmentIndex == 1){
        trailRoomSelectString = @"Good";
    }else{
        trailRoomSelectString = @"Good";
    }
}

//-(void)textViewDidBeginEditing:(UITextView *)textView{
//    textView.text = @"";
//    textView.textColor = [UIColor darkGrayColor];
//}

//-(void)textViewDidEndEditing:(UITextView *)textView{
//    if(textView.text.length>0){
//        _feedbackString = textView.text;
//        if([_feedbackString isEqualToString:@" Please provide your valuable feedback"]){
//            _feedbackString = @"";
//        }else{
//            _feedbackString = textView.text;
//        }
//    }else{
//        textView.text = @" Please provide your valuable feedback";
//        textView.textColor = [UIColor lightGrayColor];
//    }
// }

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
