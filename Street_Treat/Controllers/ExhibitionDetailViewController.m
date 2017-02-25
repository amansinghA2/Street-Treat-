//
//  ExhibitionDetailViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/24/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "ExhibitionDetailViewController.h"

@interface ExhibitionDetailViewController ()

@end

@implementation ExhibitionDetailViewController
@synthesize DetailScroll,Promopagecontol,Promoscroll,promoArr;

-(void)viewWillAppear:(BOOL)animated{
    [delegate.defaults setObject:@"ExhibitionDetailViewController" forKey:@"internetdisconnect"];
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden =true;
    self.navigationItem.hidesBackButton = YES;
    
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [commonclass addNavigationBar:self.view];
    detailData = [[NSMutableData alloc]init];
    
    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
    [back addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
    
    //log_id,latitude,logitude,radius,exhibitionID
    //static
     if([commonclass isActiveInternet] == YES){
    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%@&longitude=%@&radius=%@&exhibition_id=%d",[delegate.defaults valueForKey:@"logid"],@"19.157935",@"72.993476",@"3",[[delegate.defaults valueForKey:@"exhibition_ID"]intValue]];
    //dynamic
    //  NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&latitude=%@&longitude=%@&radius=%@",[delegate.defaults valueForKey:@"logid"],[delegate.defaults valueForKey:@"latitude"],[delegate.defaults valueForKey:@"longitude"],@"3"];
    NSLog(@"body.. %@",messageBody);
    [commonclass sendRequest:self.view mutableDta:detailData url:commonclass.exhibition_detailURL msgBody:messageBody];
     }else{
         [commonclass Redirect:self.navigationController Identifier:@"InternetDisconnectViewController"];
         //[self.view makeToast:@"Check your internet connection"];
     }
    //logid
    
    
    
    promoArr = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"Promo1.png"],[UIImage imageNamed:@"Promo2.png"],[UIImage imageNamed:@"Promo3.png"],[UIImage imageNamed:@"Promo4.png"],nil];
    Promoscroll.contentSize = CGSizeMake(Promoscroll.frame.size.width * promoArr.count, Promoscroll.frame.size.height);
    for (int j = 0; j < promoArr.count; j++) {
        CGRect frame;
        frame.origin.x = Promoscroll.frame.size.width * j;
        frame.origin.y = 0;
        frame.size = Promoscroll.frame.size;
        UIImageView* imgView = [[UIImageView alloc] init];
        imgView.image = [promoArr objectAtIndex:j];
        imgView.frame = frame;
        [Promoscroll addSubview:imgView];
    }
    
    Promopagecontol.currentPage = 0;
    Promopagecontol.numberOfPages = promoArr.count;
    [DetailScroll bringSubviewToFront:Promopagecontol];
}

- (void)sendResponse:(Common *)response data:(NSMutableArray*)data indicator:(UIActivityIndicatorView *)indicator{
    NSLog(@"data.. %@",data);
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self setupDetails:data];
        [indicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
}

-(void)setupDetails:(NSMutableArray *)arr{
    NSLog(@"arr %@",arr);
    self.storeNameLbl.text = [NSString stringWithFormat:@"%@",[[[arr valueForKey:@"items"] valueForKey:@"Exhibitiondetails"][0] valueForKey:@"title"]];
    //self.storeAddLbl.text = [NSString stringWithFormat:@"%@",[[[arr valueForKey:@"items"] valueForKey:@"Exhibitiondetails"][0] valueForKey:@"address"]];
    
    NSString * startdatetemp = [[[arr valueForKey:@"items"] valueForKey:@"Exhibitiondetails"][0] valueForKey:@"from_time"];
    NSString * enddatetemp = [[[arr valueForKey:@"items"] valueForKey:@"Exhibitiondetails"][0] valueForKey:@"end_time"];
    
    NSArray *datearr=[commonclass setDate:startdatetemp seconddate:enddatetemp];
    
    self.storeDateLbl.text = [NSString stringWithFormat:@"%@%@",datearr[0],datearr[1]];
    
//    NSString * starttimetemp = [[[arr valueForKey:@"items"] valueForKey:@"Exhibitiondetails"][0] valueForKey:@"start_time"];
//    NSString * endtimetemp = [[[arr valueForKey:@"items"] valueForKey:@"Exhibitiondetails"][0] valueForKey:@"end_time"];
//    
//    NSArray *timearr=[commonclass setTime:starttimetemp secondtime:endtimetemp];
//    self.storeTimeLbl.text = [NSString stringWithFormat:@"%@ | %@",timearr[0],timearr[1]];
    
    self.storeAwayIconLbl.text = commonclass.storeawayIcon;
    self.storeAwayLbl.text = [NSString stringWithFormat:@"%.2fM away  ",[[[[arr valueForKey:@"items"] valueForKey:@"Exhibitiondetails"][0] valueForKey:@"distance_in_miles"] doubleValue]];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!pageControlBeingUsed) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = Promoscroll.frame.size.width;
        int page = floor((Promoscroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        Promopagecontol.currentPage = page;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
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
