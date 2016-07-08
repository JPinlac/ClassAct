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
NSMutableArray *remoteFileList;

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
    
    //*****************************************************************************************
    //*****************************************************************************************
    //Create reference to firebase storage repository
    FIRStorageReference *firebaseStorageArea = [[FIRStorage storage] referenceForURL:@"gs://classact-22396.appspot.com"];
    firebaseStorageDirectory = [firebaseStorageArea child:@"files"];
    
    //*****************************************************************************************
    //*****************************************************************************************
    //Create references to default local directory structure
    defaultLocalDocumentsDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    localDirectory = [[defaultLocalDocumentsDirectoryURL path] stringByAppendingString:@"/"];
    NSLog(@"local directory: %@", localDirectory);
    
    //*****************************************************************************************
    //*****************************************************************************************
    //display local directory contents eligible for uploading
    [self displayLocalFiles];
    
    //*****************************************************************************************
    //*****************************************************************************************
    //display remote directory contents eligible for downloading
    [self queryFileRefsFromFirebase];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UploadButton:(id)sender {
    
    FIRStorageUploadTask *uploadTask =
        [
            [firebaseStorageDirectory child:_UploadFileTextField.text]
            putFile:
            [
                NSURL fileURLWithPath:
                [
                    [defaultLocalDocumentsDirectoryURL path] stringByAppendingString:[@"/" stringByAppendingString:_UploadFileTextField.text]
                ]
            ]
           metadata:NULL completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error)
            {
                if (error != NULL)
                {
                    NSLog(@"an error occured %@", error);
                }
                else
                {
                    NSLog(@"file uploaded succesfully");
                    [self saveFileRefToFirebase:_UploadFileTextField.text];
                }
            }
        ];
};

- (IBAction)DownloadButton:(id)sender {
    
    FIRStorageDownloadTask *downloadTask = [[firebaseStorageDirectory child:_DownloadFileTextField.text] writeToFile:[NSURL fileURLWithPath:[localDirectory stringByAppendingString:_DownloadFileTextField.text]] completion:^(NSURL * _Nullable URL, NSError * _Nullable error)
    {
        if (error != nil)
        {
            NSLog(@"an error occurred %@", error);// Uh-oh, an error occurred!
        } else
        {
            NSLog(@"file downloaded successfully to %@%@", localDirectory, _DownloadFileTextField.text);
            [self displayLocalFiles];
        }
    }];
}

-(void)saveFileRefToFirebase:(NSString *)fileName {
    
    FIRDatabaseReference *fireDB = [[FIRDatabase database] reference];
    FIRDatabaseReference *fileRef = [fireDB child:@"files"].childByAutoId;
    
                    FIRDatabaseQuery *existingRefsWithSameName = [fileRef queryEqualToValue:NULL childKey:_UploadFileTextField.text];
                    
                    if (existingRefsWithSameName == NULL)
                    {
                        NSLog(@"no other references with this name");
                    }
                    else
                    {
                        NSLog(@"%@", existingRefsWithSameName);
                    }
    
    NSDictionary *fileRefToAdd = @{@"fileName" : fileName};
    
    [fileRef setValue:fileRefToAdd];
}

-(void) queryFileRefsFromFirebase {
    
    FIRDatabaseReference *fireDB = [[FIRDatabase database] reference];
    FIRDatabaseReference *filesRef = [fireDB.ref child:@"files"];
    
    FIRDatabaseQuery *currentFileList = [filesRef queryOrderedByChild:@"files"];
    
    __block NSString *fileNameString = @"";
    [currentFileList observeEventType: FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot)
    {
        
        fileNameString = [fileNameString stringByAppendingString:snapshot.value[@"fileName"]];
        fileNameString = [fileNameString stringByAppendingString:@"\n"];
        _DownloadFileTextView.text = fileNameString;
        [_DownloadFileTextView reloadInputViews];
    }];
    

}

-(void) displayLocalFiles {
    
    NSFileManager *filemgr;
    NSArray *localFileList;
    int localFileCount;
    int i;
    
    filemgr =[NSFileManager defaultManager];
    localFileList = [filemgr contentsOfDirectoryAtPath:localDirectory error:NULL];
    
    localFileCount = [localFileList count];
    
    NSString *localFileListBuffer = @"";
    
    for (i = 0; i < localFileCount; i++)
    {
        localFileListBuffer = [localFileListBuffer stringByAppendingString:localFileList[i]];
        localFileListBuffer = [localFileListBuffer stringByAppendingString:@"\n"];
    };
    _UploadFileTextView.text = localFileListBuffer;

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
