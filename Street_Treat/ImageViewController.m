//
//  ImageViewController.m
//  Street_Treat
//
//  Created by Aman on 08/03/17.
//  Copyright © 2017 Digillence Rolson. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController
@synthesize imageView , imglink;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    commonclass = [[Common alloc]init];
    commonclass.delegate = self;
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 5, 30, 30);
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn.titleLabel setFont:[UIFont fontWithName:@"fontello" size:25]];
    [backBtn setTitle:commonclass.backIcon forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    backBtn.layer.shadowRadius = 1.5f;
    backBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    backBtn.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    backBtn.layer.shadowOpacity = 0.5f;
    backBtn.layer.masksToBounds = NO;
    
   
    
    UIButton *back = (UIButton *)[self.view viewWithTag:1111];
    [back addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *notifications = (UIButton *)[self.view viewWithTag:222];
    [notifications addTarget:self action:@selector(notificationsTapped) forControlEvents:UIControlEventTouchUpInside];
    UIButton *Menu = (UIButton *)[self.view viewWithTag:111];
    [Menu addTarget:self action:@selector(MenuToggle) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *current_Loc = (UIButton *)[self.view viewWithTag:444];
    current_Loc.hidden = TRUE;
    
    UISearchBar * search = (UISearchBar *)[self.view viewWithTag:11111];
    search.hidden = TRUE;
    
    DtlcheckInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    DtlcheckInBtn.frame = CGRectMake(self.view.frame.size.width - 115, self.view.frame.size.height - 100, 130, 35);
    DtlcheckInBtn.backgroundColor = [UIColor redColor];
    DtlcheckInBtn.layer.cornerRadius = 18.0f;
    [DtlcheckInBtn setTitle:@"CHECK IN" forState:UIControlStateNormal];
    [DtlcheckInBtn.titleLabel setFont:[UIFont fontWithName:@"Roboto-Bold" size:15]];
    [DtlcheckInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [DtlcheckInBtn addTarget:self action:@selector(checkInTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:DtlcheckInBtn];
    
    [self.view bringSubviewToFront:DtlcheckInBtn];
    
   // delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [commonclass addNavigationBar:self.view];
    
    _ScrollImageView.contentSize = CGSizeMake(_ScrollImageView.frame.size.width * _imagesList.count, _ScrollImageView.frame.size.height);
    
    for (int j = 0; j < _imagesList.count; j++) {
        
        CGRect frame;
        frame.origin.x = _ScrollImageView.frame.size.width * j;
        frame.origin.y = 0;
        frame.size = _ScrollImageView.frame.size;
        UIImageView* imgView = [[UIImageView alloc] init];
        imgView.frame = frame;
//        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage:)];
//        tapRecognizer.delegate = self;
//        imgView.tag = j;
    //    [imgView addGestureRecognizer:tapRecognizer];
      //  imgView.userInteractionEnabled = YES;
        [imgView setImageWithURL:[NSURL URLWithString:_imagesList[j]] placeholderImage:[UIImage imageNamed:@"splash_iPhone.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_ScrollImageView addSubview:imgView];
        [imgView addSubview:backBtn];
        [imgView bringSubviewToFront:backBtn];
    }
    
//    Promopagecontol.currentPage = 0;
//    Promopagecontol.numberOfPages = imgcnt;
//    [DetailScroll bringSubviewToFront:Promopagecontol];
//    [Promoscroll bringSubviewToFront:backBtn];

    // Do any additional setup after loading the view.
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

@end
