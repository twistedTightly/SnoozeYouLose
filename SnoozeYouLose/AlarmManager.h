//
//  AlarmManager.h
//  SnoozeYouLose
//
//  Created by Shuyang Li on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alarm.h"

@interface AlarmManager : NSObject

@property (strong, nonatomic) NSMutableArray *alarms;

- (void)addAlarm:(Alarm *)alarm;
- (void)deleteAlarmAtIndex:(NSUInteger)index;

- (void)storeAlarms;
- (void)retrieveStoredAlarms;

@end
