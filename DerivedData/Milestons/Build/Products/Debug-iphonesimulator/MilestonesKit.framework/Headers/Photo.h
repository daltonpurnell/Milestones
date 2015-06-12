//
//  Photo.h
//  Milestons
//
//  Created by Dalton on 5/3/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Parse;

@class Entry;

@interface Photo : PFObject <PFSubclassing>

@property (nonatomic, retain) Entry *entry;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) PFFile *picture;


+ (NSString *)parseClassName;

@end
