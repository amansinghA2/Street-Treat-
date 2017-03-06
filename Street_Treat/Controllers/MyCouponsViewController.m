//
//  MyCouponsViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 1/31/17.
//  Copyright © 2017 Digillence Rolson. All rights reserved.
//

#import "MyCouponsViewController.h"

@implementation MyCouponsCell
@synthesize shortTextLbl,expandBtn,longTextLbl,storeNameLbl;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@interface MyCouponsViewController ()

@end

@implementation MyCouponsViewController
@synthesize couponsTable,couponsCntLbl;
@synthesize approvalRecievedBtn,approvalPendingBtn,cancelledCouponsBtn,indicatorLine;

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   // StaticData = [[NSMutableData alloc]init];
    commonclass = [[Common alloc]init];
    couponsData = [[NSMutableData alloc]init];
    mycouponsArr = [[NSMutableArray alloc]init];
    
    awaitingArr = [[NSMutableArray alloc]init];
    cancelledArr = [[NSMutableArray alloc]init];
    validatedArr = [[NSMutableArray alloc]init];
    
    commonclass.delegate = self;
    [commonclass addNavigationBar:self.view];
    
    UIButton *backBtn = (UIButton *)[self.view viewWithTag:1111];
    [backBtn addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *menubtn = (UIButton *)[self.view viewWithTag:111];
    menubtn.hidden = TRUE;
    UIButton *notificationbtn = (UIButton *)[self.view viewWithTag:222];
    notificationbtn.hidden = TRUE;
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
    
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    current_Loc.hidden = TRUE;

    
    [self getMyCoupons];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [delegate.defaults setObject:@"MyCouponsViewController" forKey:@"internetdisconnect"];
    seg_string = @"Pending";
}

-(void)getMyCoupons{
    requestType = @"GetCoupons";
     if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@",[delegate.defaults valueForKey:@"logid"]];
    NSLog(@"messageBody.. %@",messageBody);
    NSLog(@"constant.getOffersURL.. %@",commonclass.myCouponsURL);
    [commonclass sendRequest:self.view mutableDta:couponsData url:commonclass.myCouponsURL msgBody:messageBody];
     }else{
         [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data.. %@",data);
    NSLog(@"count.. %lu",(unsigned long)[[data valueForKey:@"items"] count]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        if(data != NULL){
            if([requestType isEqualToString:@"GetCoupons"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                    [mycouponsArr removeAllObjects];
                    [awaitingArr removeAllObjects];
                    [cancelledArr removeAllObjects];
                    [validatedArr removeAllObjects];
                     NSLog(@"data.. %@",data);
                    mycouponsArr = [data valueForKey:@"items"];
                    NSLog(@"mycoupons.. %@",mycouponsArr);
                    
                    for(int i=0;i<mycouponsArr.count;i++){
                        if([[mycouponsArr[i] valueForKey:@"validated"] intValue] == 0){
                            [awaitingArr addObject:mycouponsArr[i]];
                        }else if([[mycouponsArr[i] valueForKey:@"validated"] intValue] == -1){
                            [cancelledArr addObject:mycouponsArr[i]];
                        }else if([[mycouponsArr[i] valueForKey:@"validated"] intValue] == 1){
                            [validatedArr addObject:mycouponsArr[i]];
                        }
                    }
                    
//                    NSLog(@"awaiting arr.. %lu",(unsigned long)awaitingArr.count);
//                     NSLog(@"cancelledArr arr.. %lu",(unsigned long)cancelledArr.count);
//                     NSLog(@"validatedArr arr.. %lu",(unsigned long)validatedArr.count);
                    
                  /*  if (list.get(position).validated.equals("0")) {
                        holder.txtStaus.setText("AWAITING VENDOR APPROVALS ");
                    } else if (list.get(position).validated.equals("-1")) {
                        holder.txtStaus.setText("CANCELLED");
                    } else if (list.get(position).validated.equals("1")) {
                        holder.txtStaus.setText("APPROVAL RECEIVED");
                    } else {
                        holder.txtStaus.setText("USED");
                    }*/
                    [couponsTable reloadData];

                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    couponsCntLbl.text = @"0 Coupons";
                    [self.view makeToast:@"No Coupons added yet" duration:4.0 position:CSToastPositionBottom];
                    //[self.view makeToast:[data valueForKey:@"message"]];
                }
            }
        }else{
            [self.view makeToast:@"Oops server error occured"];
        }
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([seg_string isEqualToString:@"Pending"]){
        return [awaitingArr count];
    }else if ([seg_string isEqualToString:@"Recieved"]){
        return [validatedArr count];
    }else if ([seg_string isEqualToString:@"Cancelled"]){
        return [cancelledArr count];
    }else{
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(isexpand==YES) {
        if (selectedIndex == indexPath.section) {
            return 98;
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
    cell = (MyCouponsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MyCouponsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if([seg_string isEqualToString:@"Pending"]){
        cell.shortTextLbl.text = [awaitingArr[indexPath.section] valueForKey:@"short_name"];
        [cell.expandBtn addTarget:self action:@selector(ExpandTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.expandBtn.tag = indexPath.section;
        cell.longTextLbl.text = [NSString stringWithFormat:@" %@",[awaitingArr[indexPath.section] valueForKey:@"long_name"]];
        cell.storeNameLbl.text = [NSString stringWithFormat:@" Store : %@",[awaitingArr[indexPath.section] valueForKey:@"store_name"]];
    }else if ([seg_string isEqualToString:@"Recieved"]){
        cell.shortTextLbl.text = [validatedArr[indexPath.section] valueForKey:@"short_name"];
        [cell.expandBtn addTarget:self action:@selector(ExpandTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.expandBtn.tag = indexPath.section;
        cell.longTextLbl.text = [NSString stringWithFormat:@" %@",[validatedArr[indexPath.section] valueForKey:@"long_name"]];
        cell.storeNameLbl.text = [NSString stringWithFormat:@" Store : %@",[validatedArr[indexPath.section] valueForKey:@"store_name"]];
    }else if ([seg_string isEqualToString:@"Cancelled"]){
        cell.shortTextLbl.text = [cancelledArr[indexPath.section] valueForKey:@"short_name"];
        [cell.expandBtn addTarget:self action:@selector(ExpandTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.expandBtn.tag = indexPath.section;
        cell.longTextLbl.text = [NSString stringWithFormat:@" %@",[cancelledArr[indexPath.section] valueForKey:@"long_name"]];
        cell.storeNameLbl.text = [NSString stringWithFormat:@" Store : %@",[cancelledArr[indexPath.section] valueForKey:@"store_name"]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"deals Arr.. %@",dealsArr);
//    NSString * storeID = [dealsArr[indexPath.section] valueForKey:@"store_id"];
//    [delegate.defaults setValue:storeID forKey:@"store_ID"];
//    [delegate.defaults synchronize];
//    [commonclass Redirect:self.navigationController Identifier:@"DetailViewController"];
}

-(void)ExpandTapped:(UIButton*)sender{
    selectedIndex = (long)sender.tag;
    isexpand = !isexpand;
    NSLog(@"sender.tag..%ld",(long)sender.tag);
    path = [NSIndexPath indexPathWithIndex:sender.tag];
    [self tableView:couponsTable heightForRowAtIndexPath:path];
    [couponsTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:sender.tag]] withRowAnimation:UITableViewRowAnimationFade];
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

- (IBAction)ApprovalPendingTapped:(id)sender {
    seg_string = @"Pending";
    [couponsTable setContentOffset:CGPointZero animated:YES];
    [commonclass addlistingSlideAnimation:indicatorLine button1:approvalPendingBtn];
    [couponsTable reloadData];
}

- (IBAction)ApprovalRecievedTapped:(id)sender {
    seg_string = @"Recieved";
    [couponsTable setContentOffset:CGPointZero animated:YES];
    [commonclass addlistingSlideAnimation:indicatorLine button1:approvalRecievedBtn];
    [couponsTable reloadData];
}

- (IBAction)CancelledCouponsTapped:(id)sender {
    seg_string = @"Cancelled";
    [couponsTable setContentOffset:CGPointZero animated:YES];
    [commonclass addlistingSlideAnimation:indicatorLine button1:cancelledCouponsBtn];
    [couponsTable reloadData];
}
@end
