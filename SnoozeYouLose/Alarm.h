//
//  Alarm.h
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alarm : NSObject <NSCoding>

@property (strong, nonatomic) NSDate *alarmDate;
@property (strong, nonatomic) NSString *friendName;
@property (strong, nonatomic) NSNumber *snoozeCost;
@property (nonatomic) BOOL isOn;
@property (strong, nonatomic) NSMutableArray *repeatDays;

@end
