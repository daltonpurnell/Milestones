//
//  PhotoController.h
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface PhotoController : NSObject

@property (strong, nonatomic) NSArray *photos;

+ (PhotoController *) sharedInstance;

// This method needs to pass in the location of the photo on the device
- (void)createPhoto;
- (void)loadThesePhotosFromParse;
- (void)updatePhoto:(Photo *)photo;
- (void)removePhoto:(Photo *)photo;

@end
