//
//  Scrapbook.m
//  Milestons
//
//  Created by Dalton on 5/3/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "Scrapbook.h"
#import "Entry.h"

static NSString * const ScrapbookClassName = @"Scrapbook";

@implementation Scrapbook

@dynamic photo;
@dynamic timestamp;
@dynamic titleOfScrapbook;
@dynamic entries;


+ (NSString *)parseClassName {
    return ScrapbookClassName;
}


@end
