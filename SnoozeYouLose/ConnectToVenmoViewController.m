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
    self.username = [[NSString alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getUserIDWithCompletionHandler:(void (^)(NSData *data, BOOL isSuccessful, NSError *error))completionHandler {
    
    
    
    // Initial authentication
    NSMutableURLRequest *initialAuthRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.venmo.com/v1/me?access_token=8JeYmc2CjWPyjWYRZXEL8KEFGV5yaDhA"]
                                                                      cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                  timeoutInterval:60.0];
    
    initialAuthRequest.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    // Kick off initial authentication
    NSURLSessionDataTask *initialAuthDataTask = [session dataTaskWithRequest:initialAuthRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        BOOL isGood = NO;
        if (error) {
            NSLog(@"Error when authenticating: %@", error);
            isGood = NO;
        }
        else {
            isGood = YES;

        }
        
        completionHandler(data, isGood,error);
    }];
    
    // Actually running it!

    [initialAuthDataTask resume];
}
- (IBAction)connectButtonPressed:(id)sender {
    [[Venmo sharedInstance] requestPermissions:@[VENPermissionMakePayments,
                                                 VENPermissionAccessProfile]
                         withCompletionHandler:^(BOOL success, NSError *error) {
                             if (success) {
                                 // :)
                                 NSLog(@"Now, we take your money");
                        
                                 
                                 [self getUserIDWithCompletionHandler:^(NSData *data, BOOL isSuccessful, NSError *error) {
                                     if(isSuccessful) {
                                         
                                         NSError* jsonerror;
                                         NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                                              options:kNilOptions
                                                                                                error:&jsonerror];
                                         NSNumber *userID = json[@"data"][@"user"][@"id"];
                                         
                                         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                         [defaults setObject:userID forKey:@"userID"];
                                         [defaults synchronize];
                                         [self dismissViewControllerAnimated:YES completion:nil];
                                     }
                                     else {
                                         NSLog(@"Error with getting user id: %@",error);
                                     }
                                     
                                 }];
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
