//
//  CustomScrapbookCell.h
//  Milestons
//
//  Created by Dalton on 5/11/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScrapbookController.h"

@import ParseUI;

@protocol deleteCellDelegate;

@interface CustomScrapbookCell : UITableViewCell

@property (nonatomic, strong) id <deleteCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *titleOfScrapbookLabel;

@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property (weak, nonatomic) IBOutlet PFImageView *photoImageView;

@property (strong, nonatomic) NSIndexPath *indexPath;

-(void)updateWithScrapbook:(Scrapbook *)scrapbook;

@end

@protocol deleteCellDelegate <NSObject>

- (IBAction)deleteButtonTapped:(NSIndexPath *)indexPath;

@end