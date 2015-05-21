//
//  User.m
//  Milestons
//
//  Created by Dalton on 5/17/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "User.h"


static NSString * const UserClassName = @"User";


@implementation User

@dynamic userId;
@dynamic name;
@dynamic email;

+ (NSString *)parseClassName {
    return UserClassName;
}

@end
