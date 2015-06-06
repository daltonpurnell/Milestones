//
//  EntryListViewController.h
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"

@interface EntryListViewController : UITableViewController

@property (strong, nonatomic) Entry *entry;
@property (strong, nonatomic) Scrapbook *scrapbook;

@property (nonatomic, strong) NSArray *entries;

- (void)updateWithSB:(Scrapbook *)scrapbook;


@end
