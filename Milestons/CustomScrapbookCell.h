//
//  CustomScrapbookCell.h
//  Milestons
//
//  Created by Dalton on 5/11/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScrapbookController.h"

@interface CustomScrapbookCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleOfScrapbookLabel;

@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

-(void)updateWithScrapbook:(Scrapbook *)scrapbook;

-(void)convertPFFileToUIImage:(UIImage *)image;

@end
