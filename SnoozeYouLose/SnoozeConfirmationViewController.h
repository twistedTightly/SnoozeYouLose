//
//  SnoozeConfirmationViewController.h
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/18/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnoozeConfirmationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *snoozeFeeLabel;
@property (strong, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (strong,nonatomic) NSString *snoozeFee;
@property (strong,nonatomic) NSString *displayName;
@end
