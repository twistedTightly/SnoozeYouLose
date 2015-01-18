//
//  AlarmResponseViewController.m
//  SnoozeYouLose
//
//  Created by Maribeth Rauh on 1/18/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "AlarmResponseViewController.h"

@interface AlarmResponseViewController ()

@end

@implementation AlarmResponseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alarmTurnedOff:(id)sender {
    // Alarm turned off
    NSLog(@"Alarm turned off");
}

- (IBAction)alarmSnoozed:(id)sender {
    // Send Venmo payment
    NSLog(@"Pay a friend");
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
