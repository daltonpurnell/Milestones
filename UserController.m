//
//  UserController.m
//  Milestons
//
//  Created by Dalton on 6/6/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "UserController.h"
#import "MySignUpViewController.h"

@interface UserController () <PFSignUpViewControllerDelegate>

@end


@implementation UserController

+ (UserController *) sharedInstance {
    static UserController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [UserController new];
        [sharedInstance loadUsersWithUsernameFromParse:^(NSError *error) {
            // Nothing
            
            if (error) {
                NSLog(@"Error: %@", error);
            }
        }];
    });
    return sharedInstance;
}


#pragma mark - read

-(void)loadUsersWithUsernameFromParse:(void (^)(NSError *error))completion {
    
    PFQuery *query = [PFUser query];
    
    [query whereKey:@"user" equalTo:@"emailaddress"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            completion(nil);
        } else {
            completion(error);
            
            MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
            [signUpViewController setDelegate:self];
            [signUpViewController setFields:PFSignUpFieldsDefault
             | PFSignUpFieldsSignUpButton];
            // set user name and password

        }
    }];
    
}


@end
