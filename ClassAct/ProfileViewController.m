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
    [self withBorders];
    [self backgroundImageChange];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)populateLabels{
    _nameLabel.text = _userObj.displayName;
    _emailLabel.text = _userObj.email;
    NSData *imageData = [NSData dataWithContentsOfURL:_userObj.photoURL];
    if(_userObj.photoURL != nil){
        self.profileImage.image = [UIImage imageWithData:imageData];
    } else {
        _profileImage.image = [UIImage imageNamed:@"DNA.png"];
    }
}

-(void)withBorders{
    _nameLabel.layer.borderWidth = 5.0f;
    _nameLabel.layer.borderColor = [[UIColor colorWithRed:28.0/255.0f green:158.0/255.0f blue:143.0/255.0f  alpha:0.7]CGColor];
    _nameLabel.layer.cornerRadius = 7.0f;
    
    _profileImage.layer.borderWidth = 7.0f;
    _profileImage.layer.borderColor = [[UIColor colorWithRed:240.0/255.0f green:192.0/255.0f blue:81.0/255.0f alpha:0.7]CGColor];
    _profileImage.layer.cornerRadius = 5.0f;
    
}
-(void)backgroundImageChange{
    _profileBackgroundImage.alpha = 0.2f;
}
@end
