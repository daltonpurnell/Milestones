//
//  CustomCollectionViewCell2.m
//  Milestons
//
//  Created by Dalton on 5/30/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "CustomCollectionViewCell2.h"
@import QuartzCore;


@implementation CustomCollectionViewCell2


-(void)awakeFromNib {
    
    // create drop shadow for image view
    self.imageView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(0, 1);
    self.imageView.layer.shadowOpacity = 1;
    self.imageView.layer.shadowRadius = 1.0;
    self.imageView.clipsToBounds = NO;
}

-(void)updateWithImage:(UIImage *)image {
    
    if (image) {
        self.imageView.image = image;
    } if (!image) {
        self.imageView.image = [UIImage imageNamed:@"dashedLineSquare"];
    }
}

@end
