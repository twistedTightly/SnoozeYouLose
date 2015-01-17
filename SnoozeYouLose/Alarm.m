//
//  Alarm.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "Alarm.h"

@implementation Alarm
-(id)init {
    if(!self) {
        self = [super init];
    }
    
    self.alarmDate = [[NSDate alloc] init];
    self.friendName = [[NSString alloc] init];
    self.snoozeCost = [[NSNumber alloc] init];
    self.isOn = NO;
    self.repeatDays = [[NSMutableArray alloc] init];
    return self;
    
}
-(id)initWithAlarmDate:(NSDate *)alarmDate andFriendName:(NSString *)friendName andSnoozeCost:(NSNumber *)snoozeCost andIsOn:(BOOL)isOn andRepeatDays:(NSMutableArray *)repeatDays {
    if(!self) {
        self = [super init];
    }
    self.alarmDate = alarmDate;
    self.friendName = friendName;
    self.snoozeCost = snoozeCost;
    self.isOn = isOn;
    self.repeatDays = repeatDays;
    return self;
    
}
@end
