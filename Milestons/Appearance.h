//
//  Appearance.h
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScrapbookListViewController.h"
#import "AddScrapbookViewController.h"
#import "EntryListViewController.h"
#import "AddEntryViewController.h"

@interface Appearance : NSObject

+ (void)initializeAppearanceDefaults;

+ (NSArray *)imageNames;

@end
