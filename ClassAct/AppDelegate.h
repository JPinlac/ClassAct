//
//  AppDelegate.h
//  ClassAct
//
//  Created by DetroitLabs on 6/27/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
#import <GoogleSignIn/GoogleSignIn.h>
#import "GTLCalendar.h"
#import "GTMOAuth2ViewControllerTouch.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) GTLServiceCalendar *calendarService;

@end

