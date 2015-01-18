//
//  PickFriendTableViewController.h
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/18/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alarm.h"

@interface PickFriendTableViewController : UITableViewController

@property(strong,nonatomic) NSMutableArray *friendsDisplayNames;
@property(strong,nonatomic) NSMutableArray *friendsUserIds;

@property (strong, nonatomic) Alarm *alarm;

@end
