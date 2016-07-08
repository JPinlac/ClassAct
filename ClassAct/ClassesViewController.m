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
    [self blinkTextInLabel:_toleranceLabel toColor:[UIColor redColor]];
    
    self.expectLabel.adjustsFontSizeToFitWidth = YES;
    [self changeBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)blinkTextInLabel:(UILabel *)label toColor:(UIColor *)color
{
    [UIView transitionWithView:label duration:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        // set to background color (change the color if necessary)
        label.textColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [UIView transitionWithView:label duration:6.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            label.textColor = color;
        } completion:nil];
    }];
}

-(void)changeBackground {
    _classesBackgroundImage.alpha = 0.2f;
}
@end
