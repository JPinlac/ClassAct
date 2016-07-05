//
//  FileStorageViewController.m
//  ClassAct
//
//  Created by Jeremy Lilje on 6/29/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "FileStorageViewController.h"
#import "SWRevealViewController.h"
#import <Firebase.h>
#import <UIKit/UIKit.h>

FIRStorageReference *storageFileDir;

@interface FileStorageViewController ()

@end

@implementation FileStorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // Do any additional setup after loading the view.
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage referenceForURL:@"gs://classact-22396.appspot.com"];
    storageFileDir = [storageRef child:@"files"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UploadButton:(id)sender {
    NSLog(@"********************************************************");
    NSLog(@"========================================================");
    NSLog(@"upload button pushed");
    
    NSString *localSourceForUploadFileStringDir = @"/Users/jeremylilje/DetroitLabsProjects/week07/ClassAct/ClassAct/";
    NSString *localSourceForUploadFileStringFile = _UploadFileTextField.text;
    NSString *localSourceForUploadFileString = [localSourceForUploadFileStringDir stringByAppendingString:localSourceForUploadFileStringFile];
    NSURL *localSourceForUploadFileRef = [NSURL fileURLWithPath:localSourceForUploadFileString];
    NSLog(@"localSourceForUploadFileRef is %@", localSourceForUploadFileRef);
    
    NSString *remoteTargetForUploadFileString = _UploadFileTextField.text;
    FIRStorageReference *remoteTargetForUploadFileRef = [storageFileDir child:remoteTargetForUploadFileString];
    NSLog(@"remoteTargetForUploadFileRef is %@", remoteTargetForUploadFileRef);

    FIRStorageUploadTask *uploadTask = [remoteTargetForUploadFileRef putFile:localSourceForUploadFileRef];
}

- (IBAction)DownloadButton:(id)sender {
    NSLog(@"********************************************************");
    NSLog(@"========================================================");
    NSLog(@"download button pushed");
    
    NSString *remoteSourceForDownloadFileString = _DownloadFileTextField.text;
    FIRStorageReference *remoteSourceForDownloadFileRef = [storageFileDir child:remoteSourceForDownloadFileString];
    NSLog(@"remoteSourceForDownloadFileRef is %@", remoteSourceForDownloadFileRef);
    NSString *localTargetForDownloadFileStringDir = @"/Users/jeremylilje/DetroitLabsProjects/week07/ClassAct/ClassAct/";
    NSString *localTargetForDownloadFileStringFile = _DownloadFileTextField.text;
    NSString *localTargetForDownloadFileString = [localTargetForDownloadFileStringDir stringByAppendingString:localTargetForDownloadFileStringFile];
    NSURL *localTargetForDownloadFileRef = [NSURL fileURLWithPath:localTargetForDownloadFileString];
    NSLog(@"localTargetForDownloadFileRef is %@", localTargetForDownloadFileRef);
    
    FIRStorageDownloadTask *downloadTask = [remoteSourceForDownloadFileRef writeToFile:localTargetForDownloadFileRef completion:^(NSURL * _Nullable URL, NSError * _Nullable error)
    {
        if (error != nil)
        {
            NSLog(@"an error occurred %@", error);// Uh-oh, an error occurred!
        } else
        {
            NSLog(@"file downloaded successfully!");// Local file URL for "images/island.jpg" is returned
        }
    }];
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
