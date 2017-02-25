//
//  SearchStoreViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 2/8/17.
//  Copyright © 2017 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "AppDelegate.h"
#import "ResultsViewController.h"

@interface SearchStoreViewController : UIViewController<UISearchBarDelegate>{
    Common * commonclass;
    AppDelegate * delegate;
    UINavigationController *refNavigationController;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
- (void) setReferencedNavigation:(UINavigationController *)refNavCon;

@end
