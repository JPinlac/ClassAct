//
//  CalenderViewController.h
//  ClassAct
//
//  Created by DetroitLabs on 6/30/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTLCalendar.h"
#import "GTMOAuth2ViewControllerTouch.h"
@interface CalenderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (nonatomic, strong) GTLServiceCalendar *service;
@property (nonatomic, strong) UITextView *output;
@end
