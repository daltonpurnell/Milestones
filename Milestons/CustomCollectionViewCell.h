//
//  CustomCollectionViewCell.h
//  Milestons
//
//  Created by Dalton on 5/30/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoController.h"
@import ParseUI;

@interface CustomCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet PFImageView *imageView;

-(void)updateWithPhoto:(Photo *)photo;

@end
