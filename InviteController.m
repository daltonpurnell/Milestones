//
//  InviteController.m
//  Milestons
//
//  Created by Dalton on 6/17/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "InviteController.h"

@implementation InviteController
+ (InviteController *) sharedInstance {
    static InviteController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [InviteController new];
    });
    return sharedInstance;
}


-(void)createInviteWithEmail:(NSString *)email forScrapbook: (Scrapbook *)scrapbook {
    
    Invite *invite = [Invite object];
    
    invite.emailAddress = email;
    invite.scrapbook = scrapbook;
    
    [invite saveInBackground];

}

@end
