//
//  FileStorageViewController.h
//  ClassAct
//
//  Created by Jeremy Lilje on 6/29/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileStorageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *UploadFileTextField;

@property (weak, nonatomic) IBOutlet UITextField *DownloadFileTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (weak, nonatomic) IBOutlet UITextView *UploadFileTextView;
@property (weak, nonatomic) IBOutlet UITextView *DownloadFileTextView;

@end
