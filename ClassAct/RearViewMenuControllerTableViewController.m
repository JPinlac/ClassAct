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


@interface RearViewMenuControllerTableViewController ()

@end

@implementation RearViewMenuControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menuArray = @[@"Profile", @"Classes", @"Calender", @"Log Out"];
    _menuImagesArray = @[@"profile.png", @"classesIcon.png", @"calanderIcon.png", @"LogoutIcon.png"];
    
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
    return [self.menuArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =@"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.textLabel setFont:[UIFont systemFontOfSize:26.0]];
    cell.textLabel.text=[self.menuArray objectAtIndex:indexPath.section];
//    cell.backgroundColor = [UIColor cyanColor];
    cell.imageView.image = [UIImage imageNamed:[_menuImagesArray objectAtIndex:indexPath.section]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[_menuArray objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"ClassesSegue"]) {
        UINavigationController *navController = segue.destinationViewController;
    } else if ([segue.identifier isEqualToString:@"Profile"]) {
        UINavigationController *nav2 = segue.destinationViewController;
    } 
}

@end
