//
//  AlarmManager.m
//  SnoozeYouLose
//
//  Created by Shuyang Li on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "AlarmManager.h"

@implementation AlarmManager

- (void)addAlarm:(Alarm *)alarm {
    [self.alarms addObject:alarm];
    
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"alarmDate" ascending:YES];
    [self.alarms sortUsingDescriptors:@[sortDesc]];
}

// Lazy instantiation
- (NSMutableArray *)alarms {
    if (!_alarms) {
        _alarms = [[NSMutableArray alloc] init];
    }
    return _alarms;
}

@end
