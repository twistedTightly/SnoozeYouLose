//
//  ProfilePageViewController.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/18/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "ProfilePageViewController.h"

@interface ProfilePageViewController ()

@end

@implementation ProfilePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect imageRect = self.profileImageView.frame;
    
    self.profileImageView.layer.cornerRadius = imageRect.size.height / 2;
    self.profileImageView.layer.masksToBounds = YES;
    self.profileImageView.layer.borderWidth = 0.0f;
}
-(void)viewWillAppear:(BOOL)animated {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults objectForKey:@"username"];
    NSString *displayName = [defaults objectForKey:@"display_name"];
    NSString *profile_image_url = [defaults objectForKey:@"profile_image_url"];
    if(username && displayName && profile_image_url) {
        //set username label here
        [self.userNameLabel setText:[NSString stringWithFormat:@"@%@", username]];
        //set display name here
        [self.displayNameLabel setText:displayName];
        
        
        NSURL * imageURL = [NSURL URLWithString:profile_image_url];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage * image = [UIImage imageWithData:imageData];
        [self.profileImageView setImage:image];
        
    }
    else {
        [self getProfileInfoWithCompletionHandler:^(NSData *data, BOOL isSuccessful, NSError *error) {
            if(isSuccessful) {
                
                NSError* jsonerror;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&jsonerror];
                NSDictionary *user = json[@"data"][@"user"];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *username = user[@"username"];
                [defaults setObject:username forKey:@"username"];
                NSString *displayName = user[@"display_name"];
                [defaults setObject:displayName forKey:@"display_name"];
                NSString *profile_image_url = user[@"profile_picture_url"];
                [defaults setObject:profile_image_url forKey:@"profile_image_url"];
                [defaults synchronize];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //set username label here
                    [self.userNameLabel setText:[NSString stringWithFormat:@"@%@", username]];
                    //set display name here
                    [self.displayNameLabel setText:displayName];
                    
                    NSURL * imageURL = [NSURL URLWithString:profile_image_url];
                    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
                    UIImage * image = [UIImage imageWithData:imageData];
                    [self.profileImageView setImage:image];
                });
            }
            else {
                NSLog(@"Error with getting profile info: %@",error);
            }
            
        }];
        
    }
    
    
}
-(IBAction)disconnectButtonPressed:(id)sender {
    [[Venmo sharedInstance] logout];
    //TODO: segue to connect
    [self performSegueWithIdentifier:@"goToConnectFromDisconnect" sender:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getProfileInfoWithCompletionHandler:(void (^)(NSData *data, BOOL isSuccessful, NSError *error))completionHandler {
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.venmo.com/v1/me?access_token=%@", [[Venmo sharedInstance] session].accessToken];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
