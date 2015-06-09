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
@import QuartzCore;

@implementation CustomScrapbookCell

- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor clearColor];
    self.backImageView.backgroundColor = [UIColor whiteColor];
    
// hide all buttons except edit
    self.doneButton.hidden = YES;
    self.cameraButton.hidden = YES;
    self.deleteButton.hidden = YES;
    
   // round corners on back image view
    self.backImageView.clipsToBounds = YES;
    self.backImageView.layer.cornerRadius = 5/2.0f;
    
    
    // create drop shadow for back image view
    self.backImageView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.backImageView.layer.shadowOffset = CGSizeMake(0, 1);
    self.backImageView.layer.shadowOpacity = 1;
    self.backImageView.layer.shadowRadius = 1.0;
    self.backImageView.clipsToBounds = NO;
    
    
    // create drop shadow for image view
    self.photoImageView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.photoImageView.layer.shadowOffset = CGSizeMake(0, 1);
    self.photoImageView.layer.shadowOpacity = 1;
    self.photoImageView.layer.shadowRadius = 1.0;
    self.photoImageView.clipsToBounds = NO;
    
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
    
    self.titleTextField.text = [NSString stringWithFormat:@"%@", scrapbook.titleOfScrapbook];
    self.timestampLabel.text = [NSString stringWithFormat:@"%@", formattedDate];
    
    self.photoImageView.file = scrapbook.photo;
    
    [self.photoImageView loadInBackground];

}

#pragma mark - buttons

- (IBAction)deleteButtonTapped:(id)sender  {
    [self.delegate deleteButtonTapped:self.indexPath];

}


- (IBAction)editButtonTapped:(id)sender {
    
    self.doneButton.hidden = NO;
    self.cameraButton.hidden = NO;
    self.deleteButton.hidden = NO;
    
}



- (IBAction)cameraButtonTapped:(id)sender {
    
    
}


- (IBAction)doneButtonTapped:(id)sender {
    
    self.doneButton.hidden = YES;
    self.cameraButton.hidden = YES;
    self.deleteButton.hidden = YES;
    
    // save changes to parse
    self.scrapbook.titleOfScrapbook = self.titleTextField.text;
    self.scrapbook.timestamp = [NSDate date];
    
    PFFile *imageFile = [PFFile fileWithData:UIImageJPEGRepresentation(self.imageView.image,0.95)];
    
    self.scrapbook.photo = imageFile;
    [[ScrapbookController sharedInstance] updateScrapbook:self.scrapbook];
    
    
    // reload tableview
    
}



@end
