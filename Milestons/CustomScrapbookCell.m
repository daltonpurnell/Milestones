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
    
//    UIImageView *whiteSquare = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, self.contentView.frame.size.width - 8, self.contentView.frame.size.height - 8)];
//    [whiteSquare setBackgroundColor:[UIColor whiteColor]];
//    [self.contentView addSubview:whiteSquare];
    
    self.backgroundColor = [UIColor clearColor];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

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


- (IBAction)deleteButtonTapped:(id)sender  {
    [self.delegate deleteButtonTapped:self.indexPath];

}



@end
