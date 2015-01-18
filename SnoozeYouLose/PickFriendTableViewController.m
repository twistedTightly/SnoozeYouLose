//
//  PickFriendTableViewController.m
//  SnoozeYouLose
//
//  Created by Jonathan Cobian on 1/18/15.
//  Copyright (c) 2015 Maribeth, Jonathan, Halli, Rita. All rights reserved.
//

#import "PickFriendTableViewController.h"

@interface PickFriendTableViewController ()

@end

@implementation PickFriendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.friendsDisplayNames = [[NSMutableArray alloc] init];
    self.friendsUserNames = [[NSMutableArray alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self populateFriendsWithCompletionHandler:^(NSData *data, BOOL isSuccessful, NSError *error) {
        if(isSuccessful) {
            
            NSError* jsonerror;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&jsonerror];
            NSArray *friendsArray = json[@"data"];
            for (NSDictionary *userDict in friendsArray) {
                NSString *username = userDict[@"username"];
                NSString *displayname = userDict[@"display_name"];
                [self.friendsDisplayNames addObject:displayname];
                [self.friendsUserNames addObject:username];
                NSLog(@"Added: %@",displayname);
            }
            
           
        }
        else {
            NSLog(@"Error with getting friends: %@",error);
        }
        
    }];
}
- (void)populateFriendsWithCompletionHandler:(void (^)(NSData *data, BOOL isSuccessful, NSError *error))completionHandler {
    
    // Initial authenticatio
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *userID = [defaults objectForKey:@"userID"];
    NSString *urlReq = [NSString stringWithFormat:@"https://api.venmo.com/v1/users/:%@/friends?access_token=8JeYmc2CjWPyjWYRZXEL8KEFGV5yaDhA",userID];
    NSMutableURLRequest *initialAuthRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlReq]
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.friendsDisplayNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendsCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
