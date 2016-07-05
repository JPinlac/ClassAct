//
//  AgendaMainViewController.h
//  ClassAct
//
//  Created by DetroitLabs on 6/28/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTLCalendar.h"

@interface AgendaMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (nonatomic, strong) GTLServiceCalendar *cservice;
@property (nonatomic, strong) UITextView *output;
@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;

//@property (weak, nonatomic) IBOutlet UIButton *fileStorageButton;


@end
