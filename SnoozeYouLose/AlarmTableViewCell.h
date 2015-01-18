//
//  AlarmTableViewCell.h
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlarmTableViewCellDelegate

- (void)changeAlarmOnStateForItem:(id)sender
                               To:(BOOL)state;

@end

@interface AlarmTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *friendLabel;
@property (strong, nonatomic) IBOutlet UILabel *snoozeCostLabel;
@property (strong, nonatomic) IBOutlet UISwitch *onOffSwitch;

@property (weak, nonatomic) id<AlarmTableViewCellDelegate> delegate;

@end

