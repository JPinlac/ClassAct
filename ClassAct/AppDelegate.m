//
//  AppDelegate.m
//  ClassAct
//
//  Created by DetroitLabs on 6/27/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "LogInViewController.h"


@interface AppDelegate ()

@property (nonatomic, strong) UIViewController *callDismissOnMe;

@end


//static NSString *const kKeychainItemName = @"Google Calendar API";
//static NSString *const kClientID = @"909045805467-uk2tbe28id528lvfdmfs3hv7nh0lq05h.apps.googleusercontent.com";

@implementation AppDelegate

- (void)dismissLoginView
{
    
    [_callDismissOnMe dismissViewControllerAnimated:YES completion:nil];
//    _callDismissOnMe = nil; // don't need it now, this unretains it
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    // Add any custom logic here.
    [FIRApp configure];
    
    [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    [signIn setScopes:[NSArray arrayWithObject:@"https://www.googleapis.com/auth/calendar"]];
    [GIDSignIn sharedInstance].delegate = self;
    
    // Initialize the Google Calendar API service & load existing credentials from the keychain if available.
    self.calendarService = [[GTLServiceCalendar alloc] init];
    if([FIRAuth auth].currentUser == nil) {
        [self showLoginScreen:NO];
    }
    return YES;
}

-(void) showLoginScreen:(BOOL)animated
{
    
    // Get login screen from storyboard and present it
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LogInViewController *viewController = (LogInViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
    _callDismissOnMe = viewController;
    [self.window makeKeyAndVisible];
    [self.window.rootViewController presentViewController:viewController
                                                 animated:animated
                                               completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//
//    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                                  openURL:url
//                                                        sourceApplication:sourceApplication
//                                                               annotation:annotation
//                    ];
//    // Add any custom logic here.
//
//
//    return handled;
//}
#pragma googe auth

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *, id> *)options {
    
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}
// for iOS 8 and older
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:sourceApplication
                                      annotation:annotation];
}
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error == nil) {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential =
        [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                         accessToken:authentication.accessToken];
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error) {
                                      // ...
                                  }];
        [self setAuthorizerForSignIn: signIn user:user];

        [self dismissLoginView];
    } else {
        NSLog(@"%@", error.localizedDescription);
    }
}

- (void)setAuthorizerForSignIn:(GIDSignIn *)signIn user:(GIDGoogleUser *)user {
    GTMOAuth2Authentication *auth = [[GTMOAuth2Authentication alloc] init];
    
    NSArray *scopes = [NSArray arrayWithObjects:kGTLAuthScopeCalendar, nil];
    [auth setScope:[scopes componentsJoinedByString:@" "]];
    [auth setClientID:signIn.clientID];
    [auth setClientSecret:nil];
    [auth setUserEmail:user.profile.email];
    [auth setUserID:user.userID];
    [auth setAccessToken:user.authentication.accessToken];
    [auth setRefreshToken:user.authentication.refreshToken];
    [auth setExpirationDate: user.authentication.accessTokenExpirationDate];
    self.calendarService.authorizer = auth;
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}

@end