//
//  AgendaMainViewController.m
//  ClassAct
//
//  Created by DetroitLabs on 6/28/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "AgendaMainViewController.h"
#import "SWRevealViewController.h"
@import Firebase;
#import <GoogleSignIn/GoogleSignIn.h>
#import "AppDelegate.h"

@interface AgendaMainViewController ()
@property FIRDatabaseReference *ref;

@end

@implementation AgendaMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    _ref = [[FIRDatabase database] reference];
    
    _cservice = [(AppDelegate *)[[UIApplication sharedApplication] delegate] calendarService];
    
    [self findMotivation];
    [self blinkTextInLabel:_agendaLabel toColor:[UIColor orangeColor]];
}

- (void)viewDidAppear:(BOOL)animated {

    [self performSelector:@selector(fetchEvents) withObject:nil afterDelay:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) findMotivation {
    NSArray *motivations = @[@"\"Only after the wall is broken will you find the answer.\" - Jon",
                             @"\"Your head is the best tool to break down barriers\" - Jon",
                             @"\"Quitting is for quitters and you're not a quitter!\" - Anonymous",
                             @"\"Yesterday you said tomorrow.\" -Anonymous",
                             @"\"Never forget to love yourself\" - Anonymous",
                             @"\"Don't cling to a mistake just because you spent a lot of time making it.\" - Aubrey de Gray"];
    int choice = arc4random_uniform((int)motivations.count);
    _quoteLabel.text = motivations[choice];
}
- (void)fetchEvents {
    GTLQueryCalendar *query = [GTLQueryCalendar queryForEventsListWithCalendarId:@"primary"];
    query.maxResults = 10;
    query.timeMin = [GTLDateTime dateTimeWithDate:[NSDate date]
                                         timeZone:[NSTimeZone localTimeZone]];;
    query.singleEvents = YES;
    query.orderBy = kGTLCalendarOrderByStartTime;
    
    [_cservice executeQuery:query
                   delegate:self
          didFinishSelector:@selector(displayResultWithTicket:finishedWithObject:error:)];
}

- (void)displayResultWithTicket:(GTLServiceTicket *)ticket
             finishedWithObject:(GTLCalendarEvents *)events
                          error:(NSError *)error {
    if (error == nil) {
        NSMutableString *eventString = [[NSMutableString alloc] init];
        if (events.items.count > 0) {
            for (GTLCalendarEvent *event in events) {
                GTLDateTime *start = event.start.dateTime ?: event.start.date;
                NSString *startString =
                [NSDateFormatter localizedStringFromDate:[start date]
                                               dateStyle:NSDateFormatterShortStyle
                                               timeStyle:NSDateFormatterShortStyle];
                [eventString appendFormat:@"%@ - %@\n", startString, event.summary];
            }
        } else {
            [eventString appendString:@"No upcoming events found."];
        }
        self.output.text = eventString;
    } else {
        [self showAlert:@"Error" message:error.localizedDescription];
    }
}

// Helper for showing an alert
- (void)showAlert:(NSString *)title message:(NSString *)message {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
     {
         [alert dismissViewControllerAnimated:YES completion:nil];
     }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
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
