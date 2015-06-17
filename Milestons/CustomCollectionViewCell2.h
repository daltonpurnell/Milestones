//
//  CustomCollectionViewCell2.h
//  Milestons
//
//  Created by Dalton on 5/30/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoController.h"

@import QuartzCore;

@interface CustomCollectionViewCell2 : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

-(void)updateWithImage:(UIImage *)image;

@end
