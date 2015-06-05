//
//  EntryController.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "EntryController.h"
#import "Entry.h"
#import "Scrapbook.h"
#import "ScrapbookController.h"

@interface EntryController()

@end

@implementation EntryController

+ (EntryController *) sharedInstance {
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [EntryController new];
    });
    return sharedInstance;
}


#pragma mark - Create

- (void)createEntryWithTitle: (NSString *) title description: (NSString *)description date:(NSDate *)timestamp inScrapbook: (Scrapbook *)scrapbook completion:(void (^)(BOOL succeeded, Entry *entry))completion {
    
    Entry *entry = [Entry object];
    
    entry.titleOfEntry = title;
    entry.descriptionOfEntry = description;
    entry.timestamp = timestamp;
    entry.scrapbook = scrapbook;
    
    PFUser *user = [PFUser currentUser];
    entry.user = user;
    entry.ACL = [PFACL ACLWithUser:user];
    [entry saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        completion(succeeded, entry);
    }];
    
}



#pragma mark - Read


- (void)loadTheseEntriesFromParseInScrapbook:(Scrapbook *)scrapbook completion:(void (^)(NSArray *entries, NSError *error))completion {
    
    NSLog(@"Loading entries from Parse");
    PFQuery *query = [Entry query];
    
    PFUser *user = [PFUser currentUser];
    [query whereKey:@"user" equalTo:user];
    [query whereKey:@"scrapbook" equalTo:scrapbook];
    
    // [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            completion(objects, nil);
        } else {
            completion(nil, error);
        }
    }];
    
}

#pragma mark - Update

- (void)updateEntry:(Entry *)entry {
    
//    [entry pinInBackground];
    [entry saveInBackground];
    
}

#pragma mark - Delete

- (void)removeEntry:(Entry *)entry {
    [entry deleteInBackground];
}


@end
