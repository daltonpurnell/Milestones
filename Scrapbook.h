//
//  Scrapbook.h
//  Milestons
//
//  Created by Dalton on 5/3/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Parse;

@class Entry;

@interface Scrapbook : PFObject <PFSubclassing>

@property (nonatomic, retain) UIImage * photo;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * titleOfScrapbook;
@property (nonatomic, retain) NSArray *entries;

+ (NSString *)parseClassName;


@end
