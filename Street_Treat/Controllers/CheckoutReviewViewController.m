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
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    parentsData = [[NSMutableData alloc]init];
    
    categorySelString = @"Good";
    AppealSelectString = @"Good";
    trailRoomSelectString = @"Good";
    salesmanSelectString = @"Good";
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

- (IBAction)submitTapped:(id)sender {
    
    if ([_pricetTextfield.text isEqualToString:@""]){
        [self.view makeToast:@"Price field cannot be left blank"];
    }else if([_feedBackTextView.text isEqualToString:@""]){
        [self.view makeToast:@"Feedback cannot be left blank"];
    }else{
        NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%@&ratings=%@&comments=%@&category_of_goods=%@&approximate_price=%@&salesman_review=%@&store_appeal=%@&trial_room=%@",[delegate.defaults valueForKey:@"log_id"],[delegate.defaults valueForKey:@"Store_ID"], overallShoppingLbl.text, _feedBackTextView.text , categorySelString , _pricetTextfield.text ,salesmanSelectString ,AppealSelectString ,trailRoomSelectString];
        NSLog(@"body.. %@",messageBody);
        NSLog(@"commonclass.LoginURL.. %@",commonclass.shoppingReviewUrl);
        [commonclass sendRequest:self.view mutableDta:parentsData url:commonclass.shoppingReviewUrl msgBody:messageBody];
    }
}

-(void)sendResponse:(Common *)response data:(NSMutableArray *)data indicator:(UIActivityIndicatorView *)indicator{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[data valueForKey:@"status"]intValue] == 1){
            [commonclass Redirect:self.navigationController Identifier:@"DashboardViewController"];
        }else if([[data valueForKey:@"status"]intValue] == -1){
            [commonclass logoutFunction];
        }else{
            
        }
    });
    
}

- (IBAction)closeTapped:(id)sender {
    
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
@end
