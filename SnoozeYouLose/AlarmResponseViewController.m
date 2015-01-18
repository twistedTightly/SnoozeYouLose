//
//  AlarmResponseViewController.m
//  SnoozeYouLose
//
//  Created by Maribeth Rauh on 1/18/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "AlarmResponseViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AlarmResponseViewController ()

@property (weak, nonatomic) IBOutlet UILabel *alarmFee;
@property (weak, nonatomic) IBOutlet UILabel *friendName;

@property (strong, nonatomic) AVAudioPlayer *alarmPlayer;
@property (strong, nonatomic) AVAudioPlayer *registerPlayer;

@end

@implementation AlarmResponseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *alarmSoundPath = [[NSBundle mainBundle] pathForResource:@"ring" ofType:@"wav"];
    NSURL *alarmSoundURL = [NSURL fileURLWithPath:alarmSoundPath];
    NSError *alarmSoundLoadErr;
    self.alarmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:alarmSoundURL error:&alarmSoundLoadErr];
    self.alarmPlayer.numberOfLoops = -1;
    
    if (!alarmSoundLoadErr) [self.alarmPlayer prepareToPlay];
    
    NSString *registerSoundPath = [[NSBundle mainBundle] pathForResource:@"registersound" ofType:@"wav"];
    NSURL *registerSoundURL = [NSURL fileURLWithPath:registerSoundPath];
    NSError *registerSoundLoadErr;
    self.registerPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:registerSoundURL error:&registerSoundLoadErr];
    [self.registerPlayer prepareToPlay];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //TODO: change this if this isn't what the label is supposed to be?
    [self.alarmFee setText:[NSString stringWithFormat:@"$%@",self.alarmObject.snoozeCost]];
    self.friendName.text = [NSString stringWithFormat:@"To %@", self.alarmObject.friendDisplayName];
    
    [self.alarmPlayer play];
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
    [self.alarmPlayer pause];
    [self.alarmPlayer playAtTime:[self.alarmPlayer deviceCurrentTime] + 60];
    
    [self.registerPlayer play];
    
    NSLog(@"Pay a friend with username:%@",self.alarmObject.friendUserId);
    NSString *displayName = [Venmo sharedInstance].session.user.displayName;
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
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SnoozeConfirmationViewController *vc = (SnoozeConfirmationViewController *)segue.destinationViewController;
    [vc setDisplayName:self.alarmObject.friendDisplayName];
    [vc setSnoozeFee:[NSString stringWithFormat:@"%@",self.alarmObject.snoozeCost]];
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
