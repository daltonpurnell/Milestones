//
//  UserController.h
//  Milestons
//
//  Created by Dalton on 6/6/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Parse;
@import ParseUI;

@interface UserController : NSObject

+ (UserController *)sharedInstance;

-(void)findUsersWithUsernameFromParse:(NSString *)emailAddress completion:(void (^)(PFUser *contributor, NSError *error))completion;
@end
