//
//  NearMeViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 8/22/16.
//  Copyright © 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "AppDelegate.h"
@import GoogleMaps;
#import "ProfileViewController.h"
#import "UPStackMenu.h"


@interface NearMeViewController : UIViewController<commonProtocol,GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate,UPStackMenuDelegate,CLLocationManagerDelegate,CCKFNavDrawerDelegate>{
    Common * commonclass;
    AppDelegate * delegate;
    NSMutableData * nearMeData;
    NSMutableArray * nearMeArr;
    UISearchBar * search;
    float userLatitude,userLongitude,userRadius,currentLatitude,currentLongitude;
    GMSCircle *circ;
    NSString * setType;
     UIView * flyoutView;
    UITextField *searchField;
    
    UIView * locationenablerView;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSString * locality;
}
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) CCKFNavDrawer *rootNav;

@end
