//
//  AgendaMainViewController.m
//  ClassAct
//
//  Created by DetroitLabs on 6/28/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "AgendaMainViewController.h"
#import "SWRevealViewController.h"
@import Firebase;

@interface AgendaMainViewController ()

@end

@implementation AgendaMainViewController
FIRDatabaseReference *ref;

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    ref = [[FIRDatabase database] reference];
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

@end
