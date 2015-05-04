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

@property (strong, nonatomic, readonly) NSArray *photos;

+ (PhotoController *) sharedInstance;

- (void)createPhotoWithTitle: (NSString *) title date:(NSDate *)timestamp;
- (void)updatePhoto:(Photo *)photo;
- (void)removePhoto:(Photo *)photo;

@end
