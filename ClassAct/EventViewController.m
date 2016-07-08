//
//  EventViewController.m
//  ClassAct
//
//  Created by DetroitLabs on 7/8/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "EventViewController.h"
#import "Event.h"
#import "Calendar.h"

@interface EventViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_eventsSelected count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
    Event *event = [_eventsSelected objectAtIndex:indexPath.row];
    cell.textLabel.text = [event summary];
    NSString *stringFromDate = [[self dateFormatter] stringFromDate:event.start];
    cell.detailTextLabel.text = stringFromDate;
    return cell;
}
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
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
