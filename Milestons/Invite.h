//
//  Invite.h
//  Milestons
//
//  Created by Dalton on 6/17/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScrapbookController.h"

@import Parse;

@class Scrapbook;

@interface Invite : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) Scrapbook *scrapbook;

@end
