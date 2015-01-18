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
    [self.connectToVenmoButton setUserInteractionEnabled:YES];
    [self.connectToVenmoButton setEnabled:YES];
    [self.connectToVenmoButton setHidden:NO];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getUserIDWithCompletionHandler:(void (^)(NSData *data, BOOL isSuccessful, NSError *error))completionHandler {
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.venmo.com/v1/me?access_token=%@", [[Venmo sharedInstance] session].accessToken];
    NSLog(@"hahah: %@",urlString);
    // Initial authentication
    NSMutableURLRequest *initialAuthRequest = [NSMutableURLRequest requestWithURL:
                                               [NSURL URLWithString:urlString]
                                                                      cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                  timeoutInterval:60.0];
    
    initialAuthRequest.HTTPMethod = @"GET";
    
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
                                                     VENPermissionAccessProfile,VENPermissionAccessFriends]
                             withCompletionHandler:^(BOOL success, NSError *error) {
                                 if (success) {
                                     
                                     // :)
                                     [self.connectToVenmoButton setUserInteractionEnabled:NO];
                                     [self.connectToVenmoButton setEnabled:NO];
                                     [self.connectToVenmoButton setHidden:YES];
                                     NSLog(@"Now, we take your money");
                                     
                                     NSLog(@"External: %@",[Venmo sharedInstance].session.user.externalId);
                                     [self dismissViewControllerAnimated:YES completion:nil];

                                     
                                    /* [self getUserIDWithCompletionHandler:^(NSData *data, BOOL isSuccessful, NSError *error) {
                                         if(isSuccessful) {
                                             
                                             NSError* jsonerror;
                                             NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                  options:kNilOptions
                                                                                                    error:&jsonerror];
                                             NSString *userID = json[@"data"][@"user"][@"id"];
                                             NSLog(@"user id is %@", userID);
                                             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                             [defaults setObject:userID forKey:@"userID"];
                                             [defaults synchronize];
                                             [self dismissViewControllerAnimated:YES completion:nil];
                                         }
                                         else {
                                             NSLog(@"Error with getting user id: %@",error);
                                         }
                                         
                                     }];*/
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
