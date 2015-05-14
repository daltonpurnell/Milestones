//
//  EntryController.h
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@interface EntryController : NSObject

@property (strong, nonatomic) NSArray *entries;

+ (EntryController *) sharedInstance;

- (void)createEntryWithTitle: (NSString *) title description: (NSString *)description date:(NSDate *)timestamp inScrapbook: (Scrapbook *)scrapbook;
- (void)loadTheseEntriesFromParse:(void (^)(NSError *error))completion;
- (void)updateEntry:(Entry *)entry;
- (void)removeEntry:(Entry *)entry;


@end
