//
//  SearchStoreViewController.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 2/8/17.
//  Copyright © 2017 Digillence Rolson. All rights reserved.
//

#import "SearchStoreViewController.h"

@interface SearchStoreViewController ()

@end

@implementation SearchStoreViewController
@synthesize searchbar;

- (void)viewDidLoad {
    [super viewDidLoad];
    [delegate.defaults setObject:@"SearchStoreViewController" forKey:@"internetdisconnect"];
    commonclass = [[Common alloc]init];
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    searchbar.placeholder = @"Search Stores";
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void) setReferencedNavigation:(UINavigationController *)refNavCon {
    refNavigationController = refNavCon;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    [delegate.defaults setValue:searchBar.text forKey:@"Search_Keyword"];
    [delegate.defaults setValue:@"Keyword" forKey:@"resultType"];
    [delegate.defaults setValue:@"Store" forKey:@"route"];
    [delegate.defaults synchronize];
    [self dismissViewControllerAnimated:YES completion:^{
        ResultsViewController * result = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultsViewController"];
        [refNavigationController pushViewController:result animated:YES];
    }];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
     [self.view endEditing:YES];
     [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
