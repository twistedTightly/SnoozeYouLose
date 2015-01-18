//
//  AlarmResponseViewController.m
//  SnoozeYouLose
//
//  Created by Maribeth Rauh on 1/18/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "AlarmResponseViewController.h"

@interface AlarmResponseViewController ()
@property (weak, nonatomic) IBOutlet UILabel *alarmFee;

@end

@implementation AlarmResponseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //TODO: change this if this isn't what the label is supposed to be?
    [self.alarmFee setText:[NSString stringWithFormat:@"$%@",self.alarmObject.snoozeCost]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alarmTurnedOff:(id)sender {
    // Alarm turned off
    NSLog(@"Alarm turned off");
    self.alarmObject.isOn = NO;
}

- (IBAction)alarmSnoozed:(id)sender {
    // Send Venmo payment
    NSLog(@"Pay a friend with username:%@",self.alarmObject.friendUserId);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *displayName = [defaults objectForKey:@"display_name"];
    NSString *note = nil;
    if(displayName) {
       note = [NSString stringWithFormat:@"%@ hit the snooze button!!", displayName];
        
    }
    else {
        note = @"Your friend hit the snooze button!!";
    }
    
    [[Venmo sharedInstance] sendPaymentTo:self.alarmObject.friendUserId
                                   amount:[self.alarmObject.snoozeCost integerValue]*100 // this is in cents!
                                     note:note
                        completionHandler:^(VENTransaction *transaction, BOOL success, NSError *error) {
                            if (success) {
                                NSLog(@"Transaction succeeded!");
                            }
                            else {
                                NSLog(@"Transaction failed with error: %@", [error localizedDescription]);
                            }
                        }];
    
    
    
    //update snoozes and dollars sent
    NSInteger dollarsSent = [defaults integerForKey:@"dollarsSent"];
    NSInteger snoozesHit = [defaults integerForKey:@"snoozesHit"];
    if(!(dollarsSent && snoozesHit)) {
        [defaults setInteger:[self.alarmObject.snoozeCost integerValue] forKey:@"dollarsSent"];
        [defaults setInteger:1 forKey:@"snoozesHit"];
        //update this alarm object's fee and the label?
    }
    else {
        dollarsSent = dollarsSent + [self.alarmObject.snoozeCost integerValue];
        snoozesHit = snoozesHit + 1;
        [defaults setInteger:dollarsSent forKey:@"dollarsSent"];
        [defaults setInteger:snoozesHit forKey:@"snoozesHit"];
        //update this alarm object's fee and the label?

    }
    [defaults synchronize];
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
