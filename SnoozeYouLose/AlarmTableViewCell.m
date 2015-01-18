//
//  AlarmTableViewCell.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "AlarmTableViewCell.h"

@implementation AlarmTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)switchToggled:(UISwitch *)sender {
    BOOL currentState = sender.on;
    [self.delegate changeAlarmOnStateForItem:self To:currentState];
}

@end
