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
}

- (IBAction)categoryChanged:(id)sender {
    
    if (CategorySelect.selectedSegmentIndex == 0){
        
    }else if(CategorySelect.selectedSegmentIndex == 1){
        
    }else{
        
    }
    
}

 // http://www.webtest.streettreat.in/index.php?option=com_konnect&task=customer.tokentest

- (IBAction)submitTapped:(id)sender {
   
//    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%@&ratings=%@&comments=%@&category_of_goods=%@&approximate_price=%@&salesman_review=%@&store_appeal=%@&trial_room=%@",[delegate.defaults valueForKey:@"log_id"],[delegate.defaults valueForKey:@"Store_ID"], overallShoppingLbl.text, _feedBackTextView.text ,];
//    NSLog(@"body.. %@",messageBody);
//    NSLog(@"commonclass.LoginURL.. %@",commonclass.shoppingReviewUrl);
//    [commonclass sendRequest:self.view mutableDta:parentsData url:commonclass.shoppingReviewUrl msgBody:messageBody];
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

- (IBAction)priceChanged:(id)sender {
    
    if (priceSelect.selectedSegmentIndex == 0){
        
    }else if(priceSelect.selectedSegmentIndex == 1){
        
    }else{
        
    }
}
- (IBAction)salesmanChanged:(id)sender {
    
    if (salesmanSelect.selectedSegmentIndex == 0){
        
    }else if(salesmanSelect.selectedSegmentIndex == 1){
        
    }else{
        
    }
}
- (IBAction)AppealChanged:(id)sender {
    
    if (AppealSelect.selectedSegmentIndex == 0){
        
    }else if(AppealSelect.selectedSegmentIndex == 1){
        
    }else{
        
    }
    
    
}
- (IBAction)trailRoomChanged:(id)sender {
    
    if (trailRoomSelect.selectedSegmentIndex == 0){
        
    }else if(trailRoomSelect.selectedSegmentIndex == 1){
        
    }else{
        
    }
}
@end
