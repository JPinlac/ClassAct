//
//  ClassesViewController.m
//  ClassAct
//
//  Created by DetroitLabs on 6/30/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "ClassesViewController.h"
#import "SWRevealViewController.h"

@interface ClassesViewController ()

@end

@implementation ClassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self blinkTextInLabel:_classNameLabel toColor:[UIColor purpleColor]];
//    [self blinkTextInLabel:_expectLabel toColor:[UIColor blackColor]];
    [self blinkTextInLabel:_toleranceLabel toColor:[UIColor redColor]];
    
    self.expectLabel.adjustsFontSizeToFitWidth = YES;
//    self.expectLabel.backgroundColor = [UIColor blueColor];
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

- (void)blinkTextInLabel:(UILabel *)label toColor:(UIColor *)color
{
    [UIView transitionWithView:label duration:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        // set to background color (change the color if necessary)
        label.textColor = [UIColor whiteColor];
    } completion:^(BOOL finished) {
        [UIView transitionWithView:label duration:6.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            label.textColor = color;
        } completion:nil];
    }];
}

@end
