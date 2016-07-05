//
//  ProfileViewController.m
//  ClassAct
//
//  Created by DetroitLabs on 6/30/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"
@import Firebase;

#import <GoogleSignIn/GoogleSignIn.h>

@interface ProfileViewController ()
@property (nonatomic, strong)    FIRUser *userObj;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    _userObj = [FIRAuth auth].currentUser;
    
    if (_userObj != nil) {
        
    } else {
        // No user is signed in.
    }
    [self populateLabels];
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
-(void)populateLabels{
    _nameLabel.text = _userObj.displayName;
    _emailLabel.text = _userObj.email;
    
    NSData *imageData = [NSData dataWithContentsOfURL:_userObj.photoURL];
    self.profileImage.image = [UIImage imageWithData:imageData];
//    _profileImage = _userObj.photoURL;
    
}



@end
