//
//  RepeatDayOfWeekTableViewController.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "RepeatDayOfWeekTableViewController.h"

@interface RepeatDayOfWeekTableViewController ()

@property (nonatomic) NSUInteger repeatDaysOfWeek;

@end

@implementation RepeatDayOfWeekTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Repeat";
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
    
    self.repeatDaysOfWeek = self.alarm.repeatDays;
    [self syncAlarmDaysOfWeekWithView];
}

-(void)savePressed {
    self.alarm.repeatDays = self.repeatDaysOfWeek;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cancelPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            self.repeatDaysOfWeek ^= kRepeatDayOfWeekSunday;
            break;
        case 1:
            self.repeatDaysOfWeek ^= kRepeatDayOfWeekMonday;
            break;
        case 2:
            self.repeatDaysOfWeek ^= kRepeatDayOfWeekTuesday;
            break;
        case 3:
            self.repeatDaysOfWeek ^= kRepeatDayOfWeekWednesday;
            break;
        case 4:
            self.repeatDaysOfWeek ^= kRepeatDayOfWeekThursday;
            break;
        case 5:
            self.repeatDaysOfWeek ^= kRepeatDayOfWeekFriday;
            break;
        case 6:
            self.repeatDaysOfWeek ^= kRepeatDayOfWeekSaturday;
            break;
        default:
            break;
    }
    
    [self syncAlarmDaysOfWeekWithView];
}

- (void)syncAlarmDaysOfWeekWithView {
    if (self.repeatDaysOfWeek & kRepeatDayOfWeekSunday) {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].accessoryType = UITableViewCellAccessoryNone;
    }
    if (self.repeatDaysOfWeek & kRepeatDayOfWeekMonday) {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].accessoryType = UITableViewCellAccessoryNone;
    }
    if (self.repeatDaysOfWeek & kRepeatDayOfWeekTuesday) {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]].accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]].accessoryType = UITableViewCellAccessoryNone;
    }
    if (self.repeatDaysOfWeek & kRepeatDayOfWeekWednesday) {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]].accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]].accessoryType = UITableViewCellAccessoryNone;
    }
    if (self.repeatDaysOfWeek & kRepeatDayOfWeekThursday) {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]].accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]].accessoryType = UITableViewCellAccessoryNone;
    }
    if (self.repeatDaysOfWeek & kRepeatDayOfWeekFriday) {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]].accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]].accessoryType = UITableViewCellAccessoryNone;
    }
    if (self.repeatDaysOfWeek & kRepeatDayOfWeekSaturday) {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]].accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]].accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
