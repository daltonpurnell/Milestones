//
//  EntryListViewDataSource.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "EntryListViewDataSource.h"
#import "EntryController.h"
#import "CustomEntryCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation EntryListViewDataSource


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    if ([EntryController sharedInstance].entries.count == 0) {
        return 1;
    } else {
        return [EntryController sharedInstance].entries.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

   if ([EntryController sharedInstance].entries.count == 0) {
       
       // return emptyState cell
       UITableViewCell *emptyStateCell = [tableView dequeueReusableCellWithIdentifier:@"emptyStateCell"];
       
       return emptyStateCell;
   
   }else {
       
       // return customCell
    Entry *entry = [EntryController sharedInstance].entries[indexPath.row];
    
    CustomEntryCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"entryCell"];
    
    [customCell updateWithEntry:entry];
       
    return customCell;
   }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([EntryController sharedInstance].entries.count == 0) {
        
        return tableView.frame.size.height;
        
    } else {
        
        return 250;
    }
}


#pragma mark - delete cell

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Entry *entry = [EntryController sharedInstance].entries[indexPath.row];
        
        [[EntryController sharedInstance] removeEntry:entry];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}


@end
