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
    [alarm scheduleLocalNotification];
    [self.alarms addObject:alarm];
    
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"alarmDate" ascending:YES];
    [self.alarms sortUsingDescriptors:@[sortDesc]];
}

- (void)deleteAlarmAtIndex:(NSUInteger)index {
    // unset local notification
    [self.alarms[index] unscheduleLocalNotification];
    [self.alarms removeObjectAtIndex:index];
}

- (void)storeAlarms {
    /*NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self.alarms] forKey:@"storedAlarms"];
    if (![defaults synchronize]) {
        NSLog(@"Problem");
    };*/
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *alarmsFile = [documentsDirectory stringByAppendingPathComponent:@"storedAlarms.dat"];
    [NSKeyedArchiver archiveRootObject:self.alarms toFile:alarmsFile];
}

- (void)retrieveStoredAlarms {
    /*NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *retrievedData = [defaults objectForKey:@"storedAlarms"];
    if ([retrievedData length] > 0) self.alarms = [NSKeyedUnarchiver unarchiveObjectWithData:retrievedData];*/
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *alarmsFile = [documentsDirectory stringByAppendingPathComponent:@"storedAlarms.dat"];
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
