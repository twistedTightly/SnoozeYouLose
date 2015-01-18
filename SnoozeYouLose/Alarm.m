//
//  Alarm.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "Alarm.h"
#import <UIKit/UIKit.h>

@interface Alarm ()

@property (strong, nonatomic) UILocalNotification *notification;

@end

@implementation Alarm
- (id)init {
    if(!self) {
        self = [super init];
    }
    
    self.alarmDate = [[NSDate alloc] init];
    self.friendDisplayName = [[NSString alloc] init];
    self.friendUserId = [[NSString alloc] init];
    self.snoozeCost = [[NSNumber alloc] initWithInt:1];
    self.isOn = NO;
    self.repeatDays = kRepeatDayOfWeekNotSet;
    self.notification = nil;
    return self;
    
}

#pragma mark - Local notification
- (void)scheduleLocalNotification {
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    localNotif.fireDate = self.alarmDate;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];

    localNotif.alertBody = [NSString stringWithFormat:@"Alarm %@ ($%@)", self.friendDisplayName, self.snoozeCost];
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.userInfo = @{
                            @"friendDisplayName" : self.friendDisplayName,
                            @"snoozeCost" : self.snoozeCost
                            };
    
    self.notification = localNotif;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

- (void)unscheduleLocalNotification {
    [[UIApplication sharedApplication] cancelLocalNotification:self.notification];
    self.notification = nil;
}

#pragma mark - Serialization
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.alarmDate forKey:@"alarmDate"];
    [aCoder encodeObject:self.friendDisplayName forKey:@"friendDisplayName"];
    [aCoder encodeObject:self.friendUserId forKey:@"friendUserId"];
    [aCoder encodeObject:self.snoozeCost forKey:@"snoozeCost"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isOn] forKey:@"isOn"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.repeatDays] forKey:@"repeatDays"];
    [aCoder encodeObject:self.notification forKey:@"notification"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.alarmDate = [aDecoder decodeObjectForKey:@"alarmDate"];
        self.friendDisplayName = [aDecoder decodeObjectForKey:@"friendDisplayName"];
        self.friendUserId = [aDecoder decodeObjectForKey:@"friendUserId"];
        self.snoozeCost = [aDecoder decodeObjectForKey:@"snoozeCost"];
        self.isOn = [[aDecoder decodeObjectForKey:@"isOn"] boolValue];
        self.repeatDays = [[aDecoder decodeObjectForKey:@"repeatDays"] integerValue];
        self.notification = [aDecoder decodeObjectForKey:@"notification"];
    }
    
    return self;
}

@end
