//
//  AppDelegate.h
//  Street_Treat
//
//  Created by Kamlesh Dubey on 5/12/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import <FacebookSDK/FacebookSDK.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,GIDSignInDelegate,CLLocationManagerDelegate>{
    NSString * locality;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSUserDefaults * defaults;
//@property (strong, nonatomic) NSUserDefaults * defaults;
@property(nonatomic,retain) CLLocationManager *locationManager;


@end

