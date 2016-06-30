//
//  FileStorageViewController.m
//  ClassAct
//
//  Created by Jeremy Lilje on 6/29/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "FileStorageViewController.h"
#import <Firebase.h>
#import <UIKit/UIKit.h>

@interface FileStorageViewController ()

@end

@implementation FileStorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    FIRStorage *storage = [FIRStorage storage];
    // Do any additional setup after loading the view.
//    FIRStorageReference *storageRef = [storage referenceForURL:@"gs://classact-22396.appspot.com"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UploadButton:(id)sender {
    NSLog(@"********************************************************");
    NSLog(@"========================================================");
    NSLog(@"upload button pushed");
}

- (IBAction)DownloadButton:(id)sender {
    NSLog(@"********************************************************");
    NSLog(@"========================================================");
    NSLog(@"download button pushed");
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
