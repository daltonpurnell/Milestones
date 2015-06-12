//
//  Entry.h
//  Milestons
//
//  Created by Dalton on 5/3/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Parse;

@class Photo, Scrapbook;

@interface Entry : PFObject <PFSubclassing>


@property (nonatomic, retain) NSString * descriptionOfEntry;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * titleOfEntry;
@property (nonatomic, retain) Scrapbook *scrapbook;
@property (nonatomic, retain) PFUser *user;


+ (NSString *)parseClassName;

@end
