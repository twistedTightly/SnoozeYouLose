//
//  ConnectToVenmoViewController.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "ConnectToVenmoViewController.h"
#import <Venmo-iOS-SDK/Venmo.h>


@interface ConnectToVenmoViewController ()

@end

@implementation ConnectToVenmoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)connectButtonPressed:(id)sender {
    [[Venmo sharedInstance] requestPermissions:@[VENPermissionMakePayments,
                                                 VENPermissionAccessProfile]
                         withCompletionHandler:^(BOOL success, NSError *error) {
                             if (success) {
                                 // :)
                                 NSLog(@"Now, we take your money");
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }
                             else {
                                 // :(
                                 NSLog(@"Unfortunately, this app isn't much use if you don't log in");
                                 NSLog(@"Error: %@",error);
                             }
                         }];
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
