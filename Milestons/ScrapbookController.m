//
//  ScrapbookController.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "ScrapbookController.h"
#import "Scrapbook.h"

@implementation ScrapbookController

+ (ScrapbookController *) sharedInstance {
    static ScrapbookController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [ScrapbookController new];
        [sharedInstance loadScrapbooksFromParse];
    });
    return sharedInstance;
}

#pragma mark - Create

- (void)createScrapbookWithTitle: (NSString *) title date:(NSDate *)timestamp {
    
    Scrapbook *scrapbook = [Scrapbook object];
    
    scrapbook.titleOfScrapbook = title;
    scrapbook.timestamp = timestamp;
    
    [scrapbook pinInBackground];
    [scrapbook saveInBackground];
    
}


#pragma mark - Read

- (void)loadScrapbooksFromParse {
    
    PFQuery *query = [Scrapbook query];
    
    // Without notifications to update the tableview we'll need to restart the app to get the tableview to load
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (Scrapbook *scrapbook in objects) {
            [scrapbook pinInBackground];
        }
    }];
}

- (NSArray *)scrapbooks {
    
    PFQuery *query = [Scrapbook query];
    [query fromLocalDatastore];
    return [query findObjects];
//    return [NSArray arrayWithObject:[query findObjectsInBackground]];
    
}


#pragma mark - Update

- (void)updateScrapbook:(Scrapbook *)scrapbook {
    
    [scrapbook pinInBackground];
    [scrapbook saveInBackground];
    
}

#pragma mark - Delete

- (void)removeScrapbook:(Scrapbook *)scrapbook {
    
    [scrapbook unpinInBackground];
    [scrapbook deleteInBackground];
}


@end
