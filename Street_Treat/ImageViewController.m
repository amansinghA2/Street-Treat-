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
    
    [imageView setImageWithURL:[NSURL URLWithString:imglink] placeholderImage:[UIImage imageNamed:@"splash_iPhone.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    // Do any additional setup after loading the view.
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
