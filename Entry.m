//
//  Entry.m
//  Milestons
//
//  Created by Dalton on 5/3/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "Entry.h"
#import "Photo.h"
#import "Scrapbook.h"



static NSString * const EntryClassName = @"Entry";



@implementation Entry

@dynamic descriptionOfEntry;
@dynamic timestamp;
@dynamic titleOfEntry;
@dynamic scrapbook;
@dynamic user;

+ (NSString *)parseClassName {
    return EntryClassName;
}


@end
