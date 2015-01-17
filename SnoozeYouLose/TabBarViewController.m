//
//  TabBarViewController.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/17/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // VENMO TESTING
    // Set Venmo payments to use the API by default, as opposed to switching to the app
    [[Venmo sharedInstance] setDefaultTransactionMethod:VENTransactionMethodAPI];
    
    // Request permission from the user for the app to access their Venmo account
    // This will prompt log in by switching to the Venmo app, if installed, or Safari if not
    [[Venmo sharedInstance] requestPermissions:@[VENPermissionMakePayments,
                                                 VENPermissionAccessProfile]
                         withCompletionHandler:^(BOOL success, NSError *error) {
                             if (success) {
                                 // :)
                                 NSLog(@"Now, we take your money");
                             }
                             else {
                                 // :(
                                 NSLog(@"Unfortunately, this app isn't much use if you don't log in");
                             }
                         }];
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
