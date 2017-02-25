//
//  DirectionViewController.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 2/1/17.
//  Copyright © 2017 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
@import GoogleMaps;
#import "AppDelegate.h"

@interface DirectionViewController : UIViewController{
     Common * commonclass;
     AppDelegate * delegate;
    float userLatitude,userLongitude,userRadius,currentLatitude,currentLongitude;
    NSString * userSublocality,*currentSublocality;
    
    BOOL isresponse;
}
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@end
