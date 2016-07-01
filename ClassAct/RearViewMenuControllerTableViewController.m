//
//  RearViewMenuControllerTableViewController.m
//  ClassAct
//
//  Created by DetroitLabs on 6/28/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "RearViewMenuControllerTableViewController.h"
#import "ClassesViewController.h"
#import "LogOutViewController.h"
#import "CalenderViewController.h"
#import "ProfileViewController.h"
#import "LogInViewController.h"

@import Firebase;

#import <GoogleSignIn/GoogleSignIn.h>

@interface RearViewMenuControllerTableViewController ()

@end

@implementation RearViewMenuControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menuArray = @[@"profile", @"classes", @"calender", @"storage", @"agenda", @"logOut"];
    _menuImagesArray = @[@"profile.png", @"classesIcon.png", @"calanderIcon.png", @"storage.png", @"agenda.png", @"LogoutIcon.png"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [_menuArray count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 20.;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor clearColor];
//    return headerView;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [_menuArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.textLabel setFont:[UIFont systemFontOfSize:26.0]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 5){
    NSError *error;
    [[FIRAuth auth] signOut:&error];
    if (!error) {
        NSLog(@"User is signed out");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LogInViewController *viewController = (LogInViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        [self presentViewController:viewController animated:YES completion:nil];
        
    }}
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    // Set the title of navigation bar by using the menu items
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
//    destViewController.title = [[_menuArray objectAtIndex:indexPath.row] capitalizedString];
//    
//    // Set the photo if it navigates to the PhotoView
//    if ([segue.identifier isEqualToString:@"ClassesSegue"]) {
//        UINavigationController *navController = segue.destinationViewController;
//    } else if ([segue.identifier isEqualToString:@"Profile"]) {
//        UINavigationController *nav2 = segue.destinationViewController;
//    } 
//}

@end
