//
//  InviteController.h
//  Milestons
//
//  Created by Dalton on 6/17/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScrapbookController.h"
#import "Invite.h"

@interface InviteController : NSObject

-(void)createInviteWithEmail:(NSString *)email forScrapbook: (Scrapbook *)scrapbook;

+ (InviteController *) sharedInstance;

@end
