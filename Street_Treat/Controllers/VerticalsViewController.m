//
//  VerticalsViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/19/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "VerticalsViewController.h"

@interface VerticalsViewController ()

@end

@implementation VerticalsViewController
@synthesize resultTable,locationBtn,filterBtn;

-(void)viewWillAppear:(BOOL)animated{
    [delegate.defaults setObject:@"VerticalsViewController" forKey:@"internetdisconnect"];
    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
    [back addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [commonclass addNavigationBar:self.view];
    verticalsData = [[NSMutableData alloc]init];
    verticalsArr = [[NSMutableArray alloc]init];
    [resultTable setSeparatorColor:[UIColor clearColor]];
    
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
    
    [locationBtn setTitle:commonclass.locationbaloonIcon forState:UIControlStateNormal];
    [filterBtn setTitle:commonclass.filtersIcon forState:UIControlStateNormal];
    
    seg_string = @"Verticals";
    if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%@&longitude=%@&radius=%@&type=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],[delegate.defaults valueForKey:@"radius"],[delegate.defaults valueForKey:@"verticalsCategory"]];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"commonclass.searchListURL.. %@",commonclass.searchListURL);
    [commonclass sendRequest:self.view mutableDta:verticalsData url:commonclass.searchListURL msgBody:messageBody];
    }else{
        [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
        //[self.view makeToast:@"Check your internet connection"];
    }
    // Do any additional setup after loading the view.
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data.. %@",data);
   
    dispatch_sync(dispatch_get_main_queue(), ^{
        if(data != NULL){
            if([seg_string isEqualToString:@"Verticals"]){
                if([[data valueForKey:@"status"]intValue] == 1){
                    [verticalsArr removeAllObjects];
                    verticalsArr = data;
                    self.storeCountLbl.text = [NSString stringWithFormat:@"%lu Stores",(unsigned long)[[verticalsArr valueForKey:@"items"] count]];
                }else if([[data valueForKey:@"status"]intValue] == -1){
                    [commonclass logoutFunction];
                }else{
                    self.storeCountLbl.text = [NSString stringWithFormat:@"0 Stores"];
                    [self.view makeToast:@"We could not find any stores for your result"];
                }
                [resultTable reloadData];
            }
           }else{
            [self.view makeToast:@"Oops server Error!"];
        }
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

- (IBAction)locationBtnTapped:(id)sender{
    
}


- (IBAction)filterBtnTapped:(id)sender{
    
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return [[verticalsArr valueForKey:@"items"] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    //if (indexPath.row %2==0){
    cellIdentifier = @"Normal";
    //    }else{
    //        cellIdentifier = @"Premium";
    //    }
    
    cell = (NormalListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[NormalListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
     //cell.storeNameLbl.text = [NSString stringWithFormat:@"%@",[[[verticalsArr valueForKey:@"items"]valueForKey:@"results"][indexPath.row] valueForKey:@"name"]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    if([seg_string isEqualToString:@"Homegrown"]){
      [self setData:[verticalsArr valueForKey:@"items"] indexpath:indexPath];
//    }else if([seg_string isEqualToString:@"Branded"]){
//        [self setData:brandedArr indexpath:indexPath];
//    }else if([seg_string isEqualToString:@"Designers"]){
//        [self setData:designerArr indexpath:indexPath];
//    }else if([seg_string isEqualToString:@"Exhibitions"]){
//        [self setData:exhibitionArr indexpath:indexPath];
//    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if([[delegate.defaults valueForKey:@"verticalsCategory"]isEqualToString:@"1"]){
        return [NSString stringWithFormat:@"%@",@"HIGHSTREET"];
    }else if([[delegate.defaults valueForKey:@"verticalsCategory"]isEqualToString:@"2"]){
        return [NSString stringWithFormat:@"%@",@"BRANDED"];
    }
    else{
        return [NSString stringWithFormat:@"%@",@"DESIGNERS"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}


-(void)setData:(NSMutableArray *)arr indexpath:(NSIndexPath *)indexpath{
   //[phonenoArr removeAllObjects];
    cell.storeNameLbl.text = [NSString stringWithFormat:@"%@",[arr[indexpath.row] valueForKey:@"store_name"]];
    cell.storeAddLbl.text = [NSString stringWithFormat:@"%@, %@",[arr[indexpath.row] valueForKey:@"address_1"],[arr[indexpath.row] valueForKey:@"address_2"]];
    cell.storeStarsLbl.text = commonclass.starIcon;
    cell.storeRatingLbl.text = [NSString stringWithFormat:@"%@",[arr[indexpath.row] valueForKey:@"rating"]];
    cell.storeValidCpnCodeLbl.text = [NSString stringWithFormat:@"%@ Validated Coupon Code | %@ Checkins | %@ Reviews  ",[arr[indexpath.row] valueForKey:@"valid_coupon"],[arr[indexpath.row] valueForKey:@"checkins"],[arr[indexpath.row] valueForKey:@"review_count"]];
    
  /* imgcnt = [[arr[indexpath.row] valueForKey:@"store_images"] count] ;
    for (int j = 0; j < imgcnt; j++) {
        NSString * imglink = [[arr[indexpath.row] valueForKey:@"store_images"][j] valueForKey:@"images"];
        storeimgview = [[UIImageView alloc]initWithFrame:CGRectMake(70 * j, 0, 65,cell.storeGalleryView.frame.size.height)];
        storeimgview.tag = j;
        storeimgview.layer.borderWidth = 1.0f;
        storeimgview.layer.borderColor = [[UIColor View_Border] CGColor];
        storeimgview.layer.backgroundColor = [[UIColor coupon_back]CGColor];
        storeimgview.layer.cornerRadius = 5.0f;
        [storeimgview setImageWithURL:[NSURL URLWithString:imglink] placeholderImage:[UIImage imageNamed:@"splash_iPhone.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [cell.storeGalleryView addSubview:storeimgview];
    }

//    NSString * shopforLbl = [arr[indexpath.row] valueForKey:@"shop_for"];
//    NSArray * shpArr = [shopforLbl componentsSeparatedByString:@","];
//    if(shpArr.count==1){
//        cell.storeShopForLbl.text = [NSString stringWithFormat:@"%@ ",shpArr[0]];
//    }else if (shpArr.count==2){
//        cell.storeShopForLbl.text = [NSString stringWithFormat:@"%@ | %@ ",shpArr[0],shpArr[1]];
//    }else{
//        cell.storeShopForLbl.text = [NSString stringWithFormat:@"%@ | %@ | %@",shpArr[0],shpArr[1],shpArr[2]];
//    }
    NSString * starttimetemp = [arr[indexpath.row] valueForKey:@"start_time"];
    NSString * endtimetemp = [arr[indexpath.row] valueForKey:@"end_time"];
    
    NSArray *timearr=[commonclass setTime:starttimetemp secondtime:endtimetemp];
    cell.storeTimeLbl.text = [NSString stringWithFormat:@"%@ | %@",timearr[0],timearr[1]];
    
    cell.storeAwayIconLbl.text = commonclass.storeawayIcon;
    cell.storeAwayLbl.text = [NSString stringWithFormat:@"%.2fM away  ",[[arr[indexpath.row] valueForKey:@"distance_in_miles"] doubleValue]];
   cell.storeValidCpnCodeLbl.text = [NSString stringWithFormat:@"%@ Validated Coupon Code | %@ Checkins | %@ Reviews  ",[arr[indexpath.row] valueForKey:@"valid_coupon"],[arr[indexpath.row] valueForKey:@"no_of_checkins"],@"0"];
    cell.storeDiscLbl.text = [NSString stringWithFormat:@"%@%%",[arr[indexpath.row] valueForKey:@"offer_count"]];
    cell.storecheckInBtn.layer.cornerRadius = 15.0f;
    cell.storecheckInBtn.layer.borderWidth = 1.0f;
    cell.storecheckInBtn.layer.borderColor = [[UIColor TextColor_TxtFld] CGColor];
    [cell.storePhoneBtn setTitle:commonclass.storephoneIcon forState:UIControlStateNormal];
    cell.storePhoneBtn.tag = indexpath.row;
    [cell.storePhoneBtn addTarget:self action:@selector(phoneTapped:) forControlEvents:UIControlEventTouchUpInside];*/
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if([seg_string isEqualToString:@"Homegrown"]){
//        [delegate.defaults setObject:[highstreetArr[indexPath.row] valueForKey:@"store_id"] forKey:@"store_ID"];
//        [delegate.defaults synchronize];
//        DetailViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
//        [self.navigationController pushViewController:detail animated:YES];
//    }else if([seg_string isEqualToString:@"Branded"]){
//        [delegate.defaults setObject:[brandedArr[indexPath.row] valueForKey:@"store_id"] forKey:@"store_ID"];
//        [delegate.defaults synchronize];
//        DetailViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
//        [self.navigationController pushViewController:detail animated:YES];
//    }else if([seg_string isEqualToString:@"Designers"]){
//        [delegate.defaults setObject:[designerArr[indexPath.row] valueForKey:@"store_id"] forKey:@"store_ID"];
//        [delegate.defaults synchronize];
//        DetailViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
//        [self.navigationController pushViewController:detail animated:YES];
//    }else if([seg_string isEqualToString:@"Exhibitions"]){
//        NSLog(@"exhibitionArr %@",exhibitionArr);
//        [delegate.defaults setObject:[exhibitionArr[indexPath.row] valueForKey:@"exhibition_id"] forKey:@"exhibition_ID"];
//        [delegate.defaults synchronize];
//        ExhibitionDetailViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"ExhibitionDetailViewController"];
//        [self.navigationController pushViewController:detail animated:YES];
//    }
//    
//    
//}


-(void)phoneTapped:(UIButton*)sender{
    
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
