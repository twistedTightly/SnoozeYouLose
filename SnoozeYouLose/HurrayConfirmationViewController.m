//
//  HurrayConfirmationViewController.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/18/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "HurrayConfirmationViewController.h"
#import "TabBarViewController.h"

@interface HurrayConfirmationViewController ()

@end

@implementation HurrayConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.snoozeFeeLabel setText:[NSString stringWithFormat:@"$%@",self.snoozeFee]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitScreen:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)exitScreen:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    TabBarViewController *vc = (TabBarViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainTabBarViewController"];
    
    //set the root controller to it
    [[UIApplication sharedApplication] keyWindow].rootViewController = vc;
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
