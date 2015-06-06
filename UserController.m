//
//  UserController.m
//  Milestons
//
//  Created by Dalton on 6/6/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "UserController.h"
#import "MySignUpViewController.h"
#import "ScrapbookController.h"

@interface UserController () <PFSignUpViewControllerDelegate>


@end


@implementation UserController

+ (UserController *) sharedInstance {
    static UserController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [UserController new];
    });
    return sharedInstance;
}


#pragma mark - read

-(void)findUsersWithUsernameFromParse:(NSString *)emailAddress completion:(void (^)(PFUser *contributor, NSError *error))completion {
    
    PFQuery *query = [PFUser query];
    
    [query whereKey:@"username" equalTo:emailAddress];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            
            if (objects.count == 1) {
                // add person as contributor
                // update acl
                
                PFUser *contributor = objects.firstObject;
//                [[ScrapbookController sharedInstance]addContributor:contributor toScrapbook:self.scrapbook];
                
                completion(contributor, nil);
            } else { // (objects.count == 0) (Can never have more than one)
                
                // sorry, this person does not use the app, would you like to invite them?
                //  for v2 instead of letting user invite them, sign them up
                completion(nil, nil);
            }
        } else {
            completion(nil, error);
                }
    }];
    
}


@end
