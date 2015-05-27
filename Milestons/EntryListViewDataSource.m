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

@interface EntryListViewDataSource ()<deleteCellDelegate>

@end

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
       customCell.indexPath = indexPath;
       customCell.delegate = self;
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

-(void)deleteButtonTapped:(NSIndexPath*)indexPath {
    
    Entry *entry = [[EntryController sharedInstance].entries objectAtIndex:indexPath.row];
    [[EntryController sharedInstance] removeEntry:entry];

    //    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSLog(@"cell deleted");
    
}


@end
