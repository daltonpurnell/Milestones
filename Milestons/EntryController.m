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
        [sharedInstance loadTheseEntriesFromParse:^(NSError *error) {
            // Nothing
        }];
    });
    return sharedInstance;
}


#pragma mark - Create

- (void)createEntryWithTitle: (NSString *) title description: (NSString *)description date:(NSDate *)timestamp inScrapbook: (Scrapbook *)scrapbook {
    
    Entry *entry = [Entry object];
    
    entry.titleOfEntry = title;
    entry.descriptionOfEntry = description;
    entry.scrapbook = scrapbook;
    entry.timestamp = timestamp;
    
    PFUser *user = [PFUser currentUser];
    entry.user = user;
    entry.ACL = [PFACL ACLWithUser:user];
    
    NSMutableArray *mutableEntries = [NSMutableArray arrayWithArray:scrapbook.entries];
    [mutableEntries insertObject:entry atIndex:0];
    scrapbook.entries = mutableEntries;
    
    [entry saveInBackground];
    
}



#pragma mark - Read


- (void)loadTheseEntriesFromParse:(void (^)(NSError *error))completion {
    
//    NSLog(@"Loading entries from Parse");
//    PFQuery *query = [PFQuery queryWithClassName:@"Entry"];
//    
//    PFUser *user = [PFUser currentUser];
//    [query whereKey:@"user" equalTo:user];
//    
////    [query whereKey:@"scrapbook" equalTo:scrapbook];
//    
//    __block NSArray *loadEntries = [NSArray new];
//    
//    [query includeKey:@"Photo"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
//        if (!error) {
//            for (Scrapbook *sb in objects) {
//                loadEntries = [loadEntries arrayByAddingObject:sb];
//            }
//            self.entries = loadEntries;
//            completion(nil);
//        } else {
//            completion(error);
//        }
//    }];
    
}

#pragma mark - Update

- (void)updateEntry:(Entry *)entry {
    
//    [entry pinInBackground];
    [entry saveInBackground];
    
}

#pragma mark - Delete

- (void)removeEntry:(Entry *)entry {
    
    Scrapbook *scrapbook = entry.scrapbook;
    NSMutableArray *mutableEntries = [NSMutableArray arrayWithArray:scrapbook.entries];
    [mutableEntries removeObject:entry];
    scrapbook.entries = mutableEntries;
    
//    [entry unpinInBackground];
    [entry deleteInBackground];
    [scrapbook saveInBackground];
}


@end
