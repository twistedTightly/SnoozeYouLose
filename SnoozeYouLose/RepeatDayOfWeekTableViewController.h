//
//  RepeatDayOfWeekTableViewController.h
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alarm.h"

typedef NS_OPTIONS(NSUInteger, RepeatDayOfWeekT) {
    kRepeatDayOfWeekNotSet      = 0,
    kRepeatDayOfWeekSunday      = 1 << 0,
    kRepeatDayOfWeekMonday      = 1 << 1,
    kRepeatDayOfWeekTuesday     = 1 << 2,
    kRepeatDayOfWeekWednesday   = 1 << 3,
    kRepeatDayOfWeekThursday    = 1 << 4,
    kRepeatDayOfWeekFriday      = 1 << 5,
    kRepeatDayOfWeekSaturday    = 1 << 6
};

@interface RepeatDayOfWeekTableViewController : UITableViewController

@property (strong, nonatomic) Alarm *alarm;

@end
