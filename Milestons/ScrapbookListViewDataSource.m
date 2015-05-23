//
//  ScrapbookListViewDataSource.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "ScrapbookListViewDataSource.h"
#import "ScrapbookController.h"
#import "CustomScrapbookCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ScrapbookListViewDataSource


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([ScrapbookController sharedInstance].scrapbooks.count == 0) {
        return 1;
    } else {
        return [ScrapbookController sharedInstance].scrapbooks.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([ScrapbookController sharedInstance].scrapbooks.count == 0) {
       
        // return emptyState cell
        UITableViewCell *emptyStateCell = [tableView dequeueReusableCellWithIdentifier:@"emptyStateCell"];
        
        return emptyStateCell;
        
    } else {
        
    // return customCell
    Scrapbook *scrapbook = [ScrapbookController sharedInstance].scrapbooks[indexPath.row];
    
    CustomScrapbookCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"scrapbookCell"];
    
    [customCell updateWithScrapbook:scrapbook];

    return customCell;
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([ScrapbookController sharedInstance].scrapbooks.count == 0) {
        
        return tableView.frame.size.height;
        
    } else {

        return 250;
    }
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Scrapbook *scrapbook = [ScrapbookController sharedInstance].scrapbooks[indexPath.row];
        
        [[ScrapbookController sharedInstance] removeScrapbook:scrapbook];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

@end
