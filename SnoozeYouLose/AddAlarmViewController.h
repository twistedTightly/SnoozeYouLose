//
//  AddAlarmViewController.h
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAlarmViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIDatePicker *timeDatePicker;
@property (strong, nonatomic) IBOutlet UITableView *optionsTableView;

@end
