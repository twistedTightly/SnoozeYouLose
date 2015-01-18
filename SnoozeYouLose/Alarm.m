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
    self.friendName = [[NSString alloc] init];
    self.snoozeCost = [[NSNumber alloc] init];
    self.isOn = NO;
    self.repeatDays = kRepeatDayOfWeekNotSet;
    return self;
    
}
- (id)initWithAlarmDate:(NSDate *)alarmDate
          andFriendName:(NSString *)friendName
          andSnoozeCost:(NSNumber *)snoozeCost
                andIsOn:(BOOL)isOn
          andRepeatDays:(NSUInteger)repeatDays {
    if (!self) {
        self = [super init];
    }
    self.alarmDate = alarmDate;
    self.friendName = friendName;
    self.snoozeCost = snoozeCost;
    self.isOn = isOn;
    self.repeatDays = repeatDays;
    return self;
}

#pragma mark - Serialization
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.alarmDate forKey:@"alarmDate"];
    [aCoder encodeObject:self.friendName forKey:@"friendName"];
    [aCoder encodeObject:self.snoozeCost forKey:@"snoozeCost"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isOn] forKey:@"isOn"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.repeatDays] forKey:@"repeatDays"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.alarmDate = [aDecoder decodeObjectForKey:@"alarmDate"];
        self.friendName = [aDecoder decodeObjectForKey:@"friendName"];
        self.snoozeCost = [aDecoder decodeObjectForKey:@"snoozeCost"];
        self.isOn = [[aDecoder decodeObjectForKey:@"isOn"] boolValue];
        self.repeatDays = [[aDecoder decodeObjectForKey:@"repeatDays"] integerValue];
    }
    
    return self;
}

@end
