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

FIRStorageReference *firebaseStorageArea;
FIRStorageReference *firebaseStorageDirectory;
NSURL *defaultLocalDocumentsDirectoryURL;
NSString *localDirectory;


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
    
    //Create reference to firebase storage repository
    FIRStorageReference *firebaseStorageArea = [[FIRStorage storage] referenceForURL:@"gs://classact-22396.appspot.com"];
    firebaseStorageDirectory = [firebaseStorageArea child:@"files"];
    
    //Create references to default local directory structure
    defaultLocalDocumentsDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    localDirectory = [[defaultLocalDocumentsDirectoryURL path] stringByAppendingString:@"/"];
    NSLog(@"local directory: %@", localDirectory);
    
    //display local directory contents eligible for uploading
    NSFileManager *filemgr;
    NSArray *filelist;
    int count;
    int i;
    
    filemgr =[NSFileManager defaultManager];
    filelist = [filemgr contentsOfDirectoryAtPath:localDirectory error:NULL];
    count = [filelist count];
    
    NSString *fileListBuffer = @"";

    for (i = 0; i < count; i++)
    {
        fileListBuffer = [fileListBuffer stringByAppendingString:filelist[i]];
        fileListBuffer = [fileListBuffer stringByAppendingString:@"\n"];
        //NSLog(@"%@", filelist[i]);
    };
    NSLog(@"fileListBuffer is %@", fileListBuffer);
    _UploadFileTextView.text = fileListBuffer;
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UploadButton:(id)sender {
    NSLog(@"********************************************************");
    NSLog(@"upload button pushed");
    
    FIRStorageUploadTask *uploadTask = [[[firebaseStorageArea child:@"files"] child:[@"/" stringByAppendingString:_UploadFileTextField.text]] putFile:[NSURL fileURLWithPath:[[defaultLocalDocumentsDirectoryURL path] stringByAppendingString:[@"/" stringByAppendingString:_UploadFileTextField.text]]]];
}

- (IBAction)DownloadButton:(id)sender {
    NSLog(@"********************************************************");
    NSLog(@"download button pushed");
    
    FIRStorageDownloadTask *downloadTask = [[firebaseStorageDirectory child:_DownloadFileTextField.text] writeToFile:[NSURL fileURLWithPath:[localDirectory stringByAppendingString:_DownloadFileTextField.text]] completion:^(NSURL * _Nullable URL, NSError * _Nullable error)
    {
        if (error != nil)
        {
            NSLog(@"an error occurred %@", error);// Uh-oh, an error occurred!
        } else
        {
            NSLog(@" ");
            NSLog(@"file downloaded successfully to %@%@", localDirectory, _DownloadFileTextField.text);// Local file URL for "images/island.jpg" is returned
            NSLog(@" ");
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
