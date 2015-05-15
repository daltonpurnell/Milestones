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


@implementation EntryController

+ (EntryController *) sharedInstance {
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [EntryController new];
        [sharedInstance loadTheseEntriesFromParse];
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
    
    NSMutableArray *mutableEntries = [NSMutableArray arrayWithArray:self.entries];
    [mutableEntries insertObject:scrapbook atIndex:0];
    self.entries = mutableEntries;
    
    [entry pinInBackground];
    [entry saveInBackground];

}



#pragma mark - Read


- (void)loadTheseEntriesFromParse {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Scrapbook"];
        
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
        
        self.entries = objects;
            NSLog(@"%lu", (unsigned long)self.entries.count);
            
        } else {
            
            NSLog(@"Error");
        }
        
    }];
}


- (NSArray *)entries {
    
    PFQuery *query = [Entry query];
    [query fromLocalDatastore];
    return [query findObjects];
}


#pragma mark - Update

- (void)updateEntry:(Entry *)entry {
    
    [entry pinInBackground];
    [entry saveInBackground];
    
}

#pragma mark - Delete

- (void)removeEntry:(Entry *)entry {
    
    NSMutableArray *mutableEntries = [NSMutableArray arrayWithArray:self.entries];
    [mutableEntries removeObject:entry];
    self.entries = mutableEntries;
    
    [entry unpinInBackground];
    [entry deleteInBackground];
}


@end
