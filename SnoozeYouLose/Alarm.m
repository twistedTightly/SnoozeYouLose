//
//  Alarm.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "Alarm.h"

@implementation Alarm
- (id)init {
    if(!self) {
        self = [super init];
    }
    
    self.alarmDate = [[NSDate alloc] init];
    self.friendDisplayName = [[NSString alloc] init];
    self.friendUserName = [[NSString alloc] init];
    self.snoozeCost = [[NSNumber alloc] initWithInt:1];
    self.isOn = NO;
    self.repeatDays = kRepeatDayOfWeekNotSet;
    return self;
    
}
- (id)initWithAlarmDate:(NSDate *)alarmDate
      friendDisplayName:(NSString *)friendDisplayName
         friendUserName:(NSString *)friendUserName
             snoozeCost:(NSNumber *)snoozeCost
                   isOn:(BOOL)isOn
             repeatDays:(NSUInteger)repeatDays {
    if (!self) {
        self = [super init];
    }
    self.alarmDate = alarmDate;
    self.friendDisplayName = friendDisplayName;
    self.snoozeCost = snoozeCost;
    self.isOn = isOn;
    self.repeatDays = repeatDays;
    return self;
}

#pragma mark - Serialization
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.alarmDate forKey:@"alarmDate"];
    [aCoder encodeObject:self.friendDisplayName forKey:@"friendDisplayName"];
    [aCoder encodeObject:self.friendUserName forKey:@"friendUserName"];
    [aCoder encodeObject:self.snoozeCost forKey:@"snoozeCost"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isOn] forKey:@"isOn"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.repeatDays] forKey:@"repeatDays"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.alarmDate = [aDecoder decodeObjectForKey:@"alarmDate"];
        self.friendDisplayName = [aDecoder decodeObjectForKey:@"friendDisplayName"];
        self.friendUserName = [aDecoder decodeObjectForKey:@"friendUserName"];
        self.snoozeCost = [aDecoder decodeObjectForKey:@"snoozeCost"];
        self.isOn = [[aDecoder decodeObjectForKey:@"isOn"] boolValue];
        self.repeatDays = [[aDecoder decodeObjectForKey:@"repeatDays"] integerValue];
    }
    
    return self;
}

@end
