//
//  ProfilePageViewController.h
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/18/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Venmo-iOS-SDK/Venmo.h>
@interface ProfilePageViewController : UIViewController
@property (strong,nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong,nonatomic) IBOutlet UILabel *displayNameLabel;
@property (strong,nonatomic) IBOutlet UIImageView *profileImageView;
@end
