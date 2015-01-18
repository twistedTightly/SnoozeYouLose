//
//  AlarmResponseViewController.h
//  SnoozeYouLose
//
//  Created by Maribeth Rauh on 1/18/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alarm.h"
#import <Venmo-iOS-SDK/Venmo.h>
#import "SnoozeConfirmationViewController.h"
@interface AlarmResponseViewController : UIViewController

@property (strong, nonatomic) Alarm *alarmObject;
@property (strong, nonatomic) NSString *friendDisplayName;
@property (strong, nonatomic) NSNumber *snoozeCost;

@end
