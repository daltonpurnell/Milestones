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

-(void)loadUsersWithUsernameFromParse:(void (^)(NSError *error))completion;

@end
