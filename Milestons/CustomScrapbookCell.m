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

// Get the image from Parse and load it into the image view
//    PFQuery *query = [PFQuery queryWithClassName:@"Scrapbook"];
//    
//    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//        
//        NSLog(@"Retrieved data");
//        
//        if (!error) {
//            PFFile *file = [object objectForKey:@"imageFile"];
//            
//            self.photoImageView.image = file;
//            
//            [self.photoImageView loadInBackground];
//        }
//    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithScrapbook:(Scrapbook *)scrapbook andPhoto:(UIImage *)myImage {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *date = scrapbook.timestamp;
    NSString *formattedDate = [formatter stringFromDate:date];
    
    self.titleOfScrapbookLabel.text = [NSString stringWithFormat:@"%@", scrapbook.titleOfScrapbook];
    self.timestampLabel.text = [NSString stringWithFormat:@"%@", formattedDate];
    
    
    NSData *data = UIImagePNGRepresentation(myImage);
    
    UIImage *image = [UIImage imageWithData:data];
    
    self.photoImageView.image = image;
}


#pragma mark - delete cell


- (IBAction)deleteButtonTapped:(id)sender forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Scrapbook *scrapbook = [ScrapbookController sharedInstance].scrapbooks[indexPath.row];
    
    [[ScrapbookController sharedInstance] removeScrapbook:scrapbook];
    

}



@end
