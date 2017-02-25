//
//  ViewReviewsViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/5/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "ViewReviewsViewController.h"

@implementation PositiveReviewCell
@synthesize userImg,usrCmntLbl,userCmntTimeLbl,userratingsLbl,vendorRplyTxtFld;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

@interface ViewReviewsViewController ()

@end

/*#define UIColorFromRGB(rgbValue, opacity) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:opacity]


#define ONE_TAB_COLOR  UIColorFromRGB(0x274e79, 1.0)
#define TWO_TAB_COLOR  UIColorFromRGB(0X05af6e, 1.0)
#define THREE_TAB_COLOR  UIColorFromRGB(0xffaa23, 1.0)*/

@implementation ViewReviewsViewController
@synthesize hdrLine,reviewsTable,reviewCntLbl;
@synthesize indicatorLine,AllBtn,sadBtn,happyBtn;

-(void)viewWillAppear:(BOOL)animated{
    [delegate.defaults setObject:@"ViewReviewsViewController" forKey:@"internetdisconnect"];
    self.navigationItem.hidesBackButton = YES;
    //[delegate.defaults setValue:@"myreviews" forKey:@"Reviews"];
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data.. %@",data);
     dispatch_sync(dispatch_get_main_queue(), ^{
         [allArr removeAllObjects];
         [positiveArr removeAllObjects];
         [negativeArr removeAllObjects];
         if([[data valueForKey:@"status"]intValue] == 1){
             
             for(int i=0;i<[[data valueForKey:@"items"] count];i++){
                 [allArr addObject:[data valueForKey:@"items"][i]];
                 NSLog(@"%@",allArr);
                 long int likeString = [[[data valueForKey:@"items"][i] valueForKey:@"rating"] integerValue];
                 NSLog(@"string %d is %ld..",i,likeString);
                 if(likeString >= 3){
                     [positiveArr addObject:[data valueForKey:@"items"][i]];
                 }else{
                     [negativeArr addObject:[data valueForKey:@"items"][i]];
                 }
             }
              reviewCntLbl.text = [NSString stringWithFormat:@"%lu Reviews",(unsigned long)[allArr count]];
             [reviewsTable reloadData];
             
         }else if([[data valueForKey:@"status"]intValue] == -1){
             [commonclass logoutFunction];
         }else{
             reviewCntLbl.text = [NSString stringWithFormat:@"0 Reviews"];
             [self.view makeToast:@"No reviews have been added for this store"];
         }
         
         [indicator stopAnimating];
         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    AllArr = [[NSArray alloc]init];
    allArr = [[NSMutableArray alloc]init];
    positiveArr = [[NSMutableArray alloc]init];
    typeStr = @"All";
    negativeArr = [[NSMutableArray alloc]init];
   
    [commonclass addNavigationBar:self.view];
    reviewsData = [[NSMutableData alloc]init];
    
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
  if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&store_id=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"store_ID"]];
    NSLog(@"body.. %@",messageBody);
    NSLog(@"url... %@",commonclass.viewFeedbacksURL);
    [commonclass sendRequest:self.view mutableDta:reviewsData url:commonclass.viewFeedbacksURL msgBody:messageBody];
  }else{
      [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
      //[self.view makeToast:@"Check your internet connection"];
  }
    [AllBtn setTitle:commonclass.allreviewsIcon forState:UIControlStateNormal];
    [sadBtn setTitle:commonclass.negativereviewsIcon forState:UIControlStateNormal];
    [happyBtn setTitle:commonclass.positivereviewsIcon forState:UIControlStateNormal];
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -Table View data source
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PositiveReview";
    PositiveReviewCell *cell = (PositiveReviewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[PositiveReviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if([typeStr isEqualToString:@"All"]){
        if(allArr.count == 0){
         
        }else{
            NSLog(@"count.. %lu",(unsigned long)allArr.count);
           // NSArray * allNSArr = allArr[0];
            NSLog(@"int value.. %@",allArr[indexPath.row]);
            cell.userCmntTimeLbl.text = [allArr[indexPath.row] valueForKey:@"created_on"];
            cell.usrCmntLbl.text = [allArr[indexPath.row] valueForKey:@"comments"];
            [self setratingsLbl:[[allArr[indexPath.row] valueForKey:@"rating"]intValue] label:cell.userratingsLbl];
            NSLog(@"text.. %@",[allArr[indexPath.row] valueForKey:@"reply_text"]);
            NSString * repAllstr = [NSString stringWithFormat:@"%@",[allArr[indexPath.row] valueForKey:@"reply_text"]];
            if(![repAllstr isEqualToString:@"0"]){
                cell.vendorRplyTxtFld.text = [allArr[indexPath.row] valueForKey:@"reply_text"];
            }else{
                
            }
        }
    }else if([typeStr isEqualToString:@"Positive"]){
        if(positiveArr.count == 0){
            
        }else{
            NSLog(@"count.. %lu",(unsigned long)positiveArr.count);
            // NSArray * allNSArr = allArr[0];
            NSLog(@"int value.. %@",positiveArr[indexPath.row]);
            cell.userCmntTimeLbl.text = [positiveArr[indexPath.row] valueForKey:@"created_on"];
            cell.usrCmntLbl.text = [positiveArr[indexPath.row] valueForKey:@"comments"];
            
            [self setratingsLbl:[[positiveArr[indexPath.row] valueForKey:@"rating"]intValue] label:cell.userratingsLbl];
            NSLog(@"text.. %@",[positiveArr[indexPath.row] valueForKey:@"reply_text"]);
            NSString * repAllstr = [NSString stringWithFormat:@"%@",[positiveArr[indexPath.row] valueForKey:@"reply_text"]];
            if(![repAllstr isEqualToString:@"0"]){
                cell.vendorRplyTxtFld.text = [positiveArr[indexPath.row] valueForKey:@"reply_text"];
            }else{
                
            }
        }
    }else if([typeStr isEqualToString:@"Negative"]){
        if(positiveArr.count == 0){
            
        }else{
            NSLog(@"count.. %lu",(unsigned long)negativeArr.count);
            // NSArray * allNSArr = allArr[0];
            NSLog(@"int value.. %@",negativeArr[indexPath.row]);
            cell.userCmntTimeLbl.text = [negativeArr[indexPath.row] valueForKey:@"created_on"];
            cell.usrCmntLbl.text = [negativeArr[indexPath.row] valueForKey:@"comments"];
            
            [self setratingsLbl:[[negativeArr[indexPath.row] valueForKey:@"rating"]intValue] label:cell.userratingsLbl];
            NSLog(@"text.. %@",[negativeArr[indexPath.row] valueForKey:@"reply_text"]);
            NSString * repAllstr = [NSString stringWithFormat:@"%@",[negativeArr[indexPath.row] valueForKey:@"reply_text"]];
            if(![repAllstr isEqualToString:@"0"]){
                cell.vendorRplyTxtFld.text = [negativeArr[indexPath.row] valueForKey:@"reply_text"];
            }else{
                
            }
        }
    }
    return cell;
}

-(void)setratingsLbl:(int)rating label:(UILabel*)rateLbl{
    if(rating == 1){
        rateLbl.text = commonclass.starIcon;
        rateLbl.font = [UIFont fontWithName:@"fontello" size:15.0f];
    }else if (rating == 2){
        rateLbl.text = commonclass.twostarIcon;
        rateLbl.font = [UIFont fontWithName:@"fontello" size:35.0f];
    }else if (rating == 3){
        rateLbl.text = commonclass.threestarIcon;
        rateLbl.font = [UIFont fontWithName:@"fontello" size:45.0f];
    }else if (rating == 4){
        rateLbl.text = commonclass.fourstarIcon;
        rateLbl.font = [UIFont fontWithName:@"fontello" size:55.0f];
    }else if (rating == 5){
        rateLbl.text = commonclass.fivestarIcon;
        rateLbl.font = [UIFont fontWithName:@"fontello" size:90.0f];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //return 118;
    
    if([typeStr isEqualToString:@"All"]){
        NSString * repAllstr = [NSString stringWithFormat:@"%@",[allArr[indexPath.section] valueForKey:@"reply_text"]];
        if(![repAllstr isEqualToString:@"0"]){
            return 120;
        }else{
            return 78;
        }
    }else if ([typeStr isEqualToString:@"Positive"]){
        NSString * repPositivestr = [NSString stringWithFormat:@"%@",[positiveArr[indexPath.section] valueForKey:@"reply_text"]];
        if(![repPositivestr isEqualToString:@"0"]){
            return 120;
        }else{
            return 78;
        }
    }else{
        NSString * repNegativestr = [NSString stringWithFormat:@"%@",[negativeArr[indexPath.section] valueForKey:@"reply_text"]];
        if(![repNegativestr isEqualToString:@"0"]){
            return 120;
        }else{
            return 78;
        }
    }
    
//    NSString * repAllstr = [NSString stringWithFormat:@"%@",[allArr[indexPath.row] valueForKey:@"reply_text"]];
//    if(![repAllstr isEqualToString:@"0"]){
//        return 120;
//    }else{
//        return 78;
//    }

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([typeStr isEqualToString:@"All"]){
        return [allArr count];
    }else if ([typeStr isEqualToString:@"Positive"]){
        return [positiveArr count];
    }else{
        return [negativeArr count];
    }
}

- (IBAction)AllTapped:(id)sender {
    typeStr = @"All";
    [commonclass addlistingSlideAnimation:indicatorLine button1:AllBtn];
    [reviewsTable reloadData];
}
- (IBAction)happyTapped:(id)sender {
    typeStr = @"Positive";
     [commonclass addlistingSlideAnimation:indicatorLine button1:happyBtn];
    [reviewsTable reloadData];
}
- (IBAction)sadTapped:(id)sender {
    typeStr = @"Negative";
    [commonclass addlistingSlideAnimation:indicatorLine button1:sadBtn];
    [reviewsTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
