//
//  ChatViewController.h
//  ClassAct
//
//  Created by DetroitLabs on 7/3/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JSQMessagesViewController/JSQMessagesViewController.h>

@interface ChatViewController : JSQMessagesViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@end
