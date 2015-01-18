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
    // set local notification
    [self.alarms addObject:alarm];
    [alarm scheduleLocalNotificationWithIndex:[self.alarms indexOfObject:alarm]];
    
    [self storeAlarms];
}

- (void)deleteAlarmAtIndex:(NSUInteger)index {
    // unset local notification
    [self.alarms[index] unscheduleLocalNotification];
    self.alarms[index] = nil;
    
    [self storeAlarms];
}

- (void)storeAlarms {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *alarmsFile = [documentsDirectory stringByAppendingPathComponent:@"storedAlarmsFile.dat"];
    [NSKeyedArchiver archiveRootObject:self.alarms toFile:alarmsFile];
}

- (void)retrieveStoredAlarms {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *alarmsFile = [documentsDirectory stringByAppendingPathComponent:@"storedAlarmsFile.dat"];
    self.alarms = [NSKeyedUnarchiver unarchiveObjectWithFile:alarmsFile];
}

// Lazy instantiation
- (NSMutableArray *)alarms {
    if (!_alarms) {
        _alarms = [[NSMutableArray alloc] init];
    }
    return _alarms;
}

@end
