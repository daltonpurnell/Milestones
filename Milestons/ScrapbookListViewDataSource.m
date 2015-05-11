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

    // Return the number of rows in the section.
    return [ScrapbookController sharedInstance].scrapbooks.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    Scrapbook *scrapbook = [ScrapbookController sharedInstance].scrapbooks[indexPath.row];
    
    CustomScrapbookCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"scrapbookCell"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *date = scrapbook.timestamp;
    NSString *formattedDate = [formatter stringFromDate:date];
    
    customCell.titleOfScrapbookLabel.text = [NSString stringWithFormat:@"%@", scrapbook.titleOfScrapbook];
    customCell.timestampLabel.text = [NSString stringWithFormat:@"%@", formattedDate];
    
    // why is this not working?
    
    customCell.photoImageView.image = [UIImage imageWithData:scrapbook.photo];
    customCell.photoImageView.clipsToBounds = YES;
    [self setRoundedView:customCell.photoImageView toDiameter:100.0];
    
    return customCell;
}


-(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Scrapbook *scrapbook = [ScrapbookController sharedInstance].scrapbooks[indexPath.row];
        
        [[ScrapbookController sharedInstance] removeScrapbook:scrapbook];
        
        [tableView reloadData];
        
    }
}




@end
