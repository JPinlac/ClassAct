//
//  LogInViewController.m
//  ClassAct
//
//  Created by DetroitLabs on 6/28/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "LogInViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ChatViewController.h"
@import Firebase;

#import <GoogleSignIn/GoogleSignIn.h>

@interface LogInViewController ()

@end
FIRDatabaseReference *ref;


@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ref = [[FIRDatabase database] reference];
    // TODO(developer) Configure the sign-in button look/feel
//    GIDSignInButton *googleButton  =[[GIDSignInButton alloc] init];
//    [googleButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    // Uncomment to automatically sign in the user.
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
