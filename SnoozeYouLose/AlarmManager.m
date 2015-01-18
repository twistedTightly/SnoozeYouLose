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
    
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"alarmDate" ascending:YES];
    [self.alarms sortUsingDescriptors:@[sortDesc]];
}

- (void)deleteAlarmAtIndex:(NSUInteger)index {
    // unset local notification
    [self.alarms removeObjectAtIndex:index];
}

- (void)storeAlarms {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self.alarms] forKey:@"storedAlarms"];
    if (![defaults synchronize]) {
        NSLog(@"Problem");
    };
}

- (void)retrieveStoredAlarms {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *retrievedData = [defaults objectForKey:@"storedAlarms"];
    if ([retrievedData length] > 0) self.alarms = [NSKeyedUnarchiver unarchiveObjectWithData:retrievedData];
}

// Lazy instantiation
- (NSMutableArray *)alarms {
    if (!_alarms) {
        _alarms = [[NSMutableArray alloc] init];
    }
    return _alarms;
}

@end
