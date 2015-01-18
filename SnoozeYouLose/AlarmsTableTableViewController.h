//
//  AlarmsTableTableViewController.h
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Venmo-iOS-SDK/Venmo.h>
#import "AlarmManager.h"


@interface AlarmsTableTableViewController : UITableViewController

@property (strong, nonatomic) AlarmManager *alarmManager;

@end
