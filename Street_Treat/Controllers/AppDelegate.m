//
//  AppDelegate.m
//  Street_Treat
//
//  Created by Kamlesh Dubey on 5/12/16.
//  Copyright (c) 2016 Digillence Rolson. All rights reserved.
//

#import "AppDelegate.h"
@import GoogleMaps;
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface AppDelegate (){
    GMSPlacesClient *_placesClient;
    NSDictionary *dUserInfo;
}

@end

@implementation AppDelegate
@synthesize defaults,locationManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
//    NSString * tempstr = @"qwerty\nrwererer\nqwerwerwerwer\n";
//    tempstr = [tempstr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    NSLog(@"tempstr.. %@",tempstr);
    
  /*  NSMutableArray * A_arr = [[NSMutableArray alloc]init];
    [A_arr addObject:@"3"];
    [A_arr addObject:@"4"];
    NSMutableArray * B_Arr = A_arr;
    [A_arr addObject:@"5"];
    
    NSLog(@"b_arr.. %@",B_Arr);
     NSLog(@"a_arr.. %@",A_arr);*/
    
   // [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
//    if (FBSDKAccessToken.currentAccessToken() != nil) {
//      NSLog(@"%@","@"Hello");
//    }
    
    
    if (launchOptions != nil)
    {
        //Store the data from the push.
        dUserInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dUserInfo != nil)
        {
            //Do whatever you need
        }
    }
    
    NSString *appFolderPath = [[NSBundle mainBundle] resourcePath];
    NSLog(@"%@", appFolderPath);
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
//    [FBLoginView class];
//    [FBProfilePictureView class];
    
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    [GIDSignIn sharedInstance].delegate = self;
    
    [GMSServices provideAPIKey:@"AIzaSyARNV9fPiiSy54R-ATJ2W6E2imnbINsA64"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyARNV9fPiiSy54R-ATJ2W6E2imnbINsA64"];
    
//    if (floor(NSFoundationVersionNumber) < NSFoundationVersionNumber_iOS_8_0)
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
//         UIRemoteNotificationTypeAlert| UIRemoteNotificationTypeSound];
//    else {
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//        [application registerForRemoteNotifications];
//    }
    
//    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
//                                                    UIUserNotificationTypeBadge |
//                                                    UIUserNotificationTypeSound);
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
//    [application registerUserNotificationSettings:settings];
    
    if([[UIDevice currentDevice] systemVersion].floatValue >= 8.0)
    {
        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge)];
    }
    
    //temporary for checking purpose
//    NSString * token = @"< e5988 1b088 12b99 22dd9 b453d 41501 1db42 03626 70de0 25357 ab5a9 fce68 b3bd >";
//    NSString *tokenStr = [token stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<> "]];
//    tokenStr = [tokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"tokenStr.. %@",tokenStr);
//   [defaults setValue:tokenStr forKey:@"deviceToken"];
    [defaults setValue:@"19.1183" forKey:@"latitude"];
    [defaults setValue:@"73.0276" forKey:@"longitude"];
    //[defaults setValue:@"Mahape" forKey:@"loc_name"];
    [defaults setValue:@"3" forKey:@"radius"];
    [defaults synchronize];
    
    // Override point for customization after application launch.
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];;
}


- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

//For interactive notification only
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    NSLog(@"My token is: %@", deviceToken);
//    NSString *string = [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];
//    NSString *tokenStr = [string stringByTrimmingCharactersInSet:
//                         [NSCharacterSet characterSetWithCharactersInString:@"<> "]];
//    tokenStr = [tokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"tokenStr.. %@",tokenStr);
    NSString *dt = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    dt = [dt stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",dt);
    [defaults setValue:dt forKey:@"deviceToken"];
    
//    NSString *messageBody = [NSString stringWithFormat:@"log_id=%@&device_os=%@&device_token=%@",[delegate.defaults valueForKey:@"logid"],@"ios",[delegate.defaults valueForKey:@"deviceToken"]];
//    NSLog(@"messageBody.. %@",messageBody);
//    [constant sendRequest:self.view mutableDta:dealsdata url:constant.updateDeviceToken msgBody:messageBody];
    
    [defaults synchronize];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{
    NSLog(@"Failed to get token, error: %@", error);
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    NSLog(@"%@",[defaults valueForKey:@"fborgoogle"]);
    if([[defaults valueForKey:@"fborgoogle"] isEqualToString:@"fb"]){
        return [[FBSDKApplicationDelegate sharedInstance] application:app
                                                              openURL:url
                                                    sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                           annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    }else{
        return [[GIDSignIn sharedInstance] handleURL:url
                                   sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                          annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    }
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo{
    
    if ( application.applicationState == UIApplicationStateActive ){
        if (userInfo != nil)
        {
            dUserInfo = userInfo;
        }
        
        // app was already in the foreground
    }else{
        if (userInfo != nil)
        {
            dUserInfo = userInfo;
        }
        id data = [dUserInfo objectForKey:@"data"];
        // app was just brought from background to foreground
    }
    
}

//
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    return [[GIDSignIn sharedInstance] handleURL:url
//                               sourceApplication:sourceApplication
//                                      annotation:annotation];
////    return [FBAppCall handleOpenURL:url
////                  sourceApplication:sourceApplication];
//}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    //BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    // Add any custom logic here.
    return handled;
} 

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    NSLog(@"user gplus token..%@",user.authentication.idToken);
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
    // ...
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    // Show an alert or otherwise notify the user
}
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    
}
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSString * latstring = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
     NSString * longstring = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude];
    //CLPlacemark *placemark;
   
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder cancelGeocode];
    [geoCoder reverseGeocodeLocation:locationManager.location
                   completionHandler:^(NSArray *placemarks, NSError *error)
     {
         // NSLog(@"Error is %@",error.localizedDescription);
         for (CLPlacemark *placemark in placemarks) {
             locality = [NSString stringWithFormat:@"%@",placemark.subLocality];
             [defaults setValue:locality forKey:@"updateloc_name"];
             [defaults setValue:locality forKey:@"myloc_name"];
             //[defaults setValue:locality forKey:@"loc_name"];
         }
     }];
    
   // NSLog(@"Locality.. %@",locality);

    [defaults setValue:latstring forKey:@"latitude"];
    [defaults setValue:longstring forKey:@"longitude"];
    
//    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"loc_name"]){
//        NSLog(@"mykey found");
//    }else{
//        [defaults setValue:locality forKey:@"loc_name"];
//        [defaults setValue:locality forKey:@"myloc_name"];
//    }
    [defaults synchronize];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
     [FBSDKAppEvents activateApp];
    
    if (dUserInfo != nil)
    {
        //Do whatever you need
    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
