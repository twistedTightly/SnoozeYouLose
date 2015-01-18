//
//  StatsViewController.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/18/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "StatsViewController.h"

@interface StatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dollarsSentLabel;
@property (weak, nonatomic) IBOutlet UILabel *snoozesHitLabel;

@end

@implementation StatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger dollarsSent = [defaults integerForKey:@"dollarsSent"];
    NSInteger snoozesHit = [defaults integerForKey:@"snoozesHit"];
    if(!(dollarsSent && snoozesHit)) {
        
        [defaults setInteger:0 forKey:@"dollarsSent"];
        [defaults setInteger:0 forKey:@"snoozesHit"];

    }

    [self.dollarsSentLabel setText:[NSString stringWithFormat:@"%ld",(long)dollarsSent]];
    [self.snoozesHitLabel setText:[NSString stringWithFormat:@"%ld",(long)snoozesHit]];
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
