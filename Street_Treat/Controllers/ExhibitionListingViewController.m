//
//  ExhibitionListingViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/19/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "ExhibitionListingViewController.h"

@interface ExhibitionListingViewController ()

@end

@implementation ExhibitionListingViewController
@synthesize resultTable,locationBtn,filterBtn;


-(void)viewWillAppear:(BOOL)animated{
    [delegate.defaults setObject:@"ExhibitionListingViewController" forKey:@"internetdisconnect"];
    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
    [back addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [commonclass addNavigationBar:self.view];
    exhibitionData = [[NSMutableData alloc]init];
    exhibitionsArr = [[NSMutableArray alloc]init];
    phonenoArr = [[NSMutableArray alloc]init];
    [resultTable setSeparatorColor:[UIColor clearColor]];
    [locationBtn setTitle:commonclass.locationbaloonIcon forState:UIControlStateNormal];
    [filterBtn setTitle:commonclass.filtersIcon forState:UIControlStateNormal];
    
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
     if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%@&longitude=%@&radius=%@",[delegate.defaults valueForKey:@"logid"],@"19.157935",@"72.993476",@"3"];
    //dynamic
     // NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%@&longitude=%@&radius=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],@"3"];
    NSLog(@"body.. %@",messageBody);
    [commonclass sendRequest:self.view mutableDta:exhibitionData url:commonclass.exhibition_listURL msgBody:messageBody];
     }else{
         [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data.. %lu",[[[data valueForKey:@"items"] valueForKey:@"results"] count]);
    exhibitionsArr = data;
    NSLog(@"exhibitionsArr.. %@",exhibitionsArr);
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.storeCountLbl.text = [NSString stringWithFormat:@"%lu Stores",[[[exhibitionsArr valueForKey:@"items"] valueForKey:@"Exhibitiondetails"] count]];
        [resultTable reloadData];
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
    //return 2;
    return [[[exhibitionsArr valueForKey:@"items"] valueForKey:@"Exhibitiondetails"] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.row %2==0){
    //       return 146;
    //    }else{
    return 195;
    // }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    //if (indexPath.row %2==0){
    cellIdentifier = @"Normal";
    //    }else{
    //        cellIdentifier = @"Premium";
    //    }
    
    cell = (ExhibitionNormalCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[ExhibitionNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
   
   [self setData:exhibitionsArr indexpath:indexPath];
   return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%@",@"EXHIBITIONS"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}


-(void)setData:(NSMutableArray *)arr indexpath:(NSIndexPath *)indexpath{
   cell.storeNameLbl.text = [NSString stringWithFormat:@"%@",[[[exhibitionsArr valueForKey:@"items"]valueForKey:@"Exhibitiondetails"][indexpath.row] valueForKey:@"title"]];
    
    NSString * startdatetemp = [[[exhibitionsArr valueForKey:@"items"]valueForKey:@"Exhibitiondetails"][indexpath.row] valueForKey:@"from_time"];
    NSString * enddatetemp = [[[exhibitionsArr valueForKey:@"items"]valueForKey:@"Exhibitiondetails"][indexpath.row] valueForKey:@"end_time"];
    NSArray *datearr=[commonclass setDate:startdatetemp seconddate:enddatetemp];
    cell.storeDateLbl.text = [NSString stringWithFormat:@"%@%@",datearr[0],datearr[1]];

  /*  NSString * starttimetemp = [[[exhibitionsArr valueForKey:@"items"]valueForKey:@"Exhibitiondetails"][indexpath.row] valueForKey:@"start_time"];
   NSString * endtimetemp = [[[exhibitionsArr valueForKey:@"items"]valueForKey:@"Exhibitiondetails"][indexpath.row] valueForKey:@"end_time"];
   NSArray *timearr=[commonclass setTime:starttimetemp secondtime:endtimetemp];
   cell.storeTimeLbl.text = [NSString stringWithFormat:@"%@ | %@",timearr[0],timearr[1]];
    */
    
    cell.storeAddLbl.text = [NSString stringWithFormat:@"%@",[[[exhibitionsArr valueForKey:@"items"]valueForKey:@"Exhibitiondetails"][indexpath.row] valueForKey:@"address"]];
    
    cell.storeAwayIconLbl.text = commonclass.storeawayIcon;
    cell.storeAwayLbl.text = [NSString stringWithFormat:@"%.2fM away  ",[[[[exhibitionsArr valueForKey:@"items"]valueForKey:@"Exhibitiondetails"][indexpath.row] valueForKey:@"distance_in_miles"] doubleValue]];
    
    imgcnt = [[[[exhibitionsArr valueForKey:@"items"]valueForKey:@"Exhibitiondetails"][indexpath.row] valueForKey:@"gallery_images"] count] ;
    for (int j = 0; j < imgcnt; j++) {
        NSString * imglink = [[[[exhibitionsArr valueForKey:@"items"]valueForKey:@"Exhibitiondetails"][indexpath.row] valueForKey:@"gallery_images"][j] valueForKey:@"images"];
        storeimgview = [[UIImageView alloc]initWithFrame:CGRectMake(70 * j, 0, 65,cell.storeGalleryView.frame.size.height)];
        storeimgview.tag = j;
        storeimgview.layer.borderWidth = 1.0f;
        storeimgview.layer.borderColor = [[UIColor View_Border] CGColor];
        storeimgview.layer.backgroundColor = [[UIColor coupon_back]CGColor];
        storeimgview.layer.cornerRadius = 5.0f;
        [storeimgview setImageWithURL:[NSURL URLWithString:imglink] placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [cell.storeGalleryView addSubview:storeimgview];
    }
    
     cell.storeAttendingLbl.text = [NSString stringWithFormat:@"%@",[[[exhibitionsArr valueForKey:@"items"]valueForKey:@"Exhibitiondetails"][indexpath.row] valueForKey:@"attending"]];

   
    cell.storecheckInBtn.layer.cornerRadius = 15.0f;
    cell.storecheckInBtn.layer.borderWidth = 1.0f;
    cell.storecheckInBtn.layer.borderColor = [[UIColor TextColor_TxtFld] CGColor];
    [cell.storePhoneBtn setTitle:commonclass.storephoneIcon forState:UIControlStateNormal];
    cell.storePhoneBtn.tag = indexpath.row;
    [phonenoArr addObject:[[[exhibitionsArr valueForKey:@"items"]valueForKey:@"Exhibitiondetails"][indexpath.row] valueForKey:@"phone_numbers"]];
    [cell.storePhoneBtn addTarget:self action:@selector(phoneTapped:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"exhibitionArr %@",[[[exhibitionsArr valueForKey:@"items"] valueForKey:@"Exhibitiondetails"][indexPath.row] valueForKey:@"exhibition_id"]);
    NSString * exhibition_ID = [[[exhibitionsArr valueForKey:@"items"] valueForKey:@"Exhibitiondetails"][indexPath.row] valueForKey:@"exhibition_id"];
    [delegate.defaults setValue:exhibition_ID forKey:@"exhibition_ID"];
    [delegate.defaults synchronize];
    ExhibitionDetailViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"ExhibitionDetailViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}


-(void)phoneTapped:(UIButton*)sender{
   // NSLog(@"number..%@",[phonenoArr objectAtIndex:sender.tag]);
    NSString *dialNumber =[NSString stringWithFormat:@"telprompt://%@",[phonenoArr objectAtIndex:sender.tag]];
    UIApplication *app = [UIApplication sharedApplication];
    NSString *dialThis = [NSString stringWithFormat:@"%@", dialNumber];
    NSURL *url = [NSURL URLWithString:dialThis];
    [app openURL:url];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UIImagePickerView delegate
-(NSString *)replaceNullValueByEmptyValue:(NSString *)stringPassed
{
    if ([stringPassed isEqual:[NSNull null]] || [stringPassed isEqualToString:@"<null>"]|| [stringPassed isEqualToString:@"<nil>"] || [stringPassed isEqualToString:@"(null)"])
    {
        return @"";
    }
    else
    {
        return stringPassed;
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([info objectForKey:UIImagePickerControllerEditedImage]) {
       
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark


#pragma mark Gallery image
-(void)selectFromGallery
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }];
    }
    else{
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}
#pragma mark

#pragma mark cameraImage
-(void)selectFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
        }
        else{
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        
    }
    
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
