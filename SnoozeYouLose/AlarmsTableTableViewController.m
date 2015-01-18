//
//  AlarmsTableTableViewController.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "AlarmsTableTableViewController.h"
#import "AlarmTableViewCell.h"
#import "AddAlarmTableViewController.h"

@interface AlarmsTableTableViewController ()

@end

@implementation AlarmsTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundView = nil;
    
    //make + green in uppper right
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:184.0f/255.0f green:233.0f/255.0f blue:134.0f/255.0f alpha:1.0f];
    if([[Venmo sharedInstance] isSessionValid]) {
        NSLog(@"Session already valid");
        
        
    }
    else {
        NSLog(@"Going to connect");
        [self performSegueWithIdentifier:@"connectToVenmoSegue" sender:self];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.alarmManager.alarms count];
}

// Lazy Instantiation
- (AlarmManager *)alarmManager {
    if (!_alarmManager) {
        _alarmManager = [[AlarmManager alloc] init];
    }
    return _alarmManager;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlarmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alarmCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell) {
        cell = [[AlarmTableViewCell alloc] init];
    }
    
    Alarm *currentAlarm = self.alarmManager.alarms[indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateStyle = NSDateFormatterNoStyle;
    cell.timeLabel.text = [dateFormatter stringFromDate:currentAlarm.alarmDate];
    cell.friendLabel.text = currentAlarm.friendDisplayName;
    cell.snoozeCostLabel.text = [NSString stringWithFormat:@"$%@", currentAlarm.snoozeCost];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"addAlarmSegue"]) {
        UINavigationController *navController = segue.destinationViewController;
        AddAlarmTableViewController *addAlarmController = (AddAlarmTableViewController *)navController.topViewController;
        addAlarmController.alarmManager = self.alarmManager;
    }
}


@end
