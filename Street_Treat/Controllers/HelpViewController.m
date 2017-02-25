//
//  HelpViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 9/6/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController
@synthesize helpArr,helpPageControl,HelpScroll,skipBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    [delegate.defaults setObject:@"HelpViewController" forKey:@"internetdisconnect"];
    constant = [[Common alloc]init];
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]==NO)
    {
       // skipBtn.hidden = TRUE;
        [self.view bringSubviewToFront:skipBtn];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        // skipBtn.hidden = TRUE;
        [constant addNavigationBar:self.view];
    }
    UIButton *backBtn = (UIButton *)[self.view viewWithTag:1111];
    [backBtn addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *menubtn = (UIButton *)[self.view viewWithTag:111];
    menubtn.hidden = TRUE;
    UIButton *notificationbtn = (UIButton *)[self.view viewWithTag:222];
    notificationbtn.hidden = TRUE;
    UISearchBar *search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    current_Loc.hidden = TRUE;
    
    helpArr = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"help1.png"],[UIImage imageNamed:@"help2.png"],[UIImage imageNamed:@"help3.png"],[UIImage imageNamed:@"help4.png"],[UIImage imageNamed:@"help5.png"],nil];
    HelpScroll.contentSize = CGSizeMake(HelpScroll.frame.size.width * helpArr.count, HelpScroll.frame.size.height);
    for (int j = 0; j < helpArr.count; j++) {
        CGRect frame;
        frame.origin.x = HelpScroll.frame.size.width * j;
        frame.origin.y = 0;
        frame.size = HelpScroll.frame.size;
        UIImageView* imgView = [[UIImageView alloc] init];
        imgView.image = [helpArr objectAtIndex:j];
        imgView.frame = frame;
        [HelpScroll addSubview:imgView];
    }
    
    helpPageControl.currentPage = 0;
    helpPageControl.numberOfPages = helpArr.count;
    helpPageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emptyDot_iPhone.png"]];
    helpPageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"filledDot_iPhone.png"]];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skipTapped:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!pageControlBeingUsed) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = HelpScroll.frame.size.width;
        int page = floor((HelpScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        helpPageControl.currentPage = page;
       // if(page == [helpArr count] - 1){
        
        //}
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (IBAction)skipTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
