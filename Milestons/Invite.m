//
//  Invite.m
//  Milestons
//
//  Created by Dalton on 6/17/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "Invite.h"

static NSString * const InviteClassName = @"Invite";

@implementation Invite

@dynamic emailAddress;
@dynamic scrapbook;

+ (NSString *)parseClassName {
    return InviteClassName;
}

@end
