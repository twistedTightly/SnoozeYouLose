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
    
    // Repeat
    if (self.currentAlarm.repeatDays == (kRepeatDayOfWeekSunday|kRepeatDayOfWeekMonday|kRepeatDayOfWeekTuesday|kRepeatDayOfWeekWednesday|kRepeatDayOfWeekThursday|kRepeatDayOfWeekFriday|kRepeatDayOfWeekSaturday)) {
        self.repeatLabel.text = @"Every day";
    } else if (self.currentAlarm.repeatDays == (kRepeatDayOfWeekMonday|kRepeatDayOfWeekTuesday|kRepeatDayOfWeekWednesday|kRepeatDayOfWeekThursday|kRepeatDayOfWeekFriday)) {
        self.repeatLabel.text = @"Weekdays";
    } else if (self.currentAlarm.repeatDays == (kRepeatDayOfWeekSunday|kRepeatDayOfWeekSaturday)) {
        self.repeatLabel.text = @"Weekends";
    } else if (self.currentAlarm.repeatDays == 0) {
        self.repeatLabel.text = @"Never";
    } else {
        NSMutableString *tempStr = [[NSMutableString alloc] init];
        if (self.currentAlarm.repeatDays & kRepeatDayOfWeekMonday) {
            [tempStr appendString:@"Mon "];
        }
        if (self.currentAlarm.repeatDays & kRepeatDayOfWeekTuesday) {
            [tempStr appendString:@"Tue "];
        }
        if (self.currentAlarm.repeatDays & kRepeatDayOfWeekWednesday) {
            [tempStr appendString:@"Wed "];
        }
        if (self.currentAlarm.repeatDays & kRepeatDayOfWeekThursday) {
            [tempStr appendString:@"Thu "];
        }
        if (self.currentAlarm.repeatDays & kRepeatDayOfWeekFriday) {
            [tempStr appendString:@"Fri "];
        }
        if (self.currentAlarm.repeatDays & kRepeatDayOfWeekSaturday) {
            [tempStr appendString:@"Sat "];
        }
        if (self.currentAlarm.repeatDays & kRepeatDayOfWeekSunday) {
            [tempStr appendString:@"Sun "];
        }
        self.repeatLabel.text = [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    // Snooze Fee
    self.snoozeFeeLabel.text = [NSString stringWithFormat:@"$%@", self.currentAlarm.snoozeCost];
    
    // Buddy
    self.buddyLabel.text = self.currentAlarm.friendDisplayName;
    
    [self.tableView reloadData];
}

-(void)savePressed {
    
    NSDate *pickedAlarmDate = [self.timeDatePicker date];
    self.currentAlarm.alarmDate = pickedAlarmDate;
    
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



@end
