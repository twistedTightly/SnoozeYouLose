//
//  AddAlarmTableViewController.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "AddAlarmTableViewController.h"
#import "SetSnoozeFeeViewController.h"
#import "RepeatDayOfWeekTableViewController.h"
#import "PickFriendTableViewController.h"

@interface AddAlarmTableViewController ()

@property (strong, nonatomic) Alarm *currentAlarm;
@property (weak, nonatomic) IBOutlet UILabel *repeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *snoozeFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *buddyLabel;

@end

@implementation AddAlarmTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
    saveButton.frame = CGRectMake(0,0,15,15);
    [saveButton addTarget:self action:@selector(savePressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    [self.navigationItem setRightBarButtonItem:saveBarButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(0,0,15,15);
    [cancelButton addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    [self.navigationItem setLeftBarButtonItem:cancelBarButton];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

-(void)savePressed {
#warning: Actually save the alarm
    [self.alarmManager addAlarm:self.currentAlarm];
    self.currentAlarm = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)cancelPressed {
    self.currentAlarm = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"setSnoozeFeeSegue"]) {
        ((SetSnoozeFeeViewController *)segue.destinationViewController).alarm = self.currentAlarm;
    } else if ([segue.identifier isEqualToString:@"repeatDayOfWeekSegue"]) {
        ((RepeatDayOfWeekTableViewController *)segue.destinationViewController).alarm = self.currentAlarm;
    } else if ([segue.identifier isEqualToString:@"pickFriendSegue"]) {
        ((PickFriendTableViewController *)segue.destinationViewController).alarm = self.currentAlarm;
    }
}

// Lazy instantiation
- (Alarm *)currentAlarm {
    if (!_currentAlarm) {
        _currentAlarm = [[Alarm alloc] init];
    }
    return _currentAlarm;
}



#pragma mark - Table view data source

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
