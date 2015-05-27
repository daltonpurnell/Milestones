//
//  Photo.m
//  Milestons
//
//  Created by Dalton on 5/3/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "Photo.h"
#import "Entry.h"

static NSString * const PhotoClassName = @"Photo";

@implementation Photo

@dynamic entry;
@dynamic user;


+ (NSString *)parseClassName {
    return PhotoClassName;
}

@end
