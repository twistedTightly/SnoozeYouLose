//
//  SnoozeConfirmationViewController.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/18/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "SnoozeConfirmationViewController.h"

@interface SnoozeConfirmationViewController ()

@end

@implementation SnoozeConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.snoozeFeeLabel setText:[NSString stringWithFormat:@"$%@",self.snoozeFee]];
    [self.displayNameLabel setText:[NSString stringWithFormat:@"to %@!",self.displayName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end