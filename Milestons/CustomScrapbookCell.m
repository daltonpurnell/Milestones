//
//  CustomScrapbookCell.m
//  Milestons
//
//  Created by Dalton on 5/11/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "CustomScrapbookCell.h"

#import "EntryController.h"

#import "ScrapbookController.h"

@implementation CustomScrapbookCell

- (void)awakeFromNib {

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.backgroundColor = [UIColor clearColor];
    
}

-(void)updateWithScrapbook:(Scrapbook *)scrapbook {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *date = scrapbook.timestamp;
    NSString *formattedDate = [formatter stringFromDate:date];
    
    self.titleOfScrapbookLabel.text = [NSString stringWithFormat:@"%@", scrapbook.titleOfScrapbook];
    self.timestampLabel.text = [NSString stringWithFormat:@"%@", formattedDate];
        
    self.photoImageView.file = scrapbook.photo;
    
    [self.photoImageView loadInBackground];
    
}

#pragma mark - delete cell


- (IBAction)deleteButtonTapped:(id)sender forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Scrapbook *scrapbook = [ScrapbookController sharedInstance].scrapbooks[indexPath.row];
    
    [[ScrapbookController sharedInstance] removeScrapbook:scrapbook];
    

}



@end
