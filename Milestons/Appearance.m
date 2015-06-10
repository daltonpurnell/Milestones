//
//  Appearance.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "Appearance.h"
#import "ScrapbookListViewController.h"

#import "AddScrapbookViewController.h"
#import "EntryListViewController.h"

#import "AddEntryViewController.h"


@implementation Appearance


+ (void)initializeAppearanceDefaults {
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:255/255.0 alpha:1]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:226/255.0 green:170/255.0 blue:253/255.0 alpha:1]];
    
    [[UIToolbar appearance] setBarTintColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:255/255.0 alpha:1]];
    
    [[UIToolbar appearance] setTintColor:[UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1]];
    
    [[UILabel appearance] setTextColor:[UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1]];
    
    [[UINavigationBar appearance] setTranslucent:NO];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                        [UIColor colorWithRed:122/255.0 green:197/255.0 blue:237/255.0 alpha:1],
                                                        NSForegroundColorAttributeName,
                                                        [UIFont fontWithName:@"SystemFont" size: 22.0],
                                                        NSFontAttributeName,
                                                        nil]];
    
}



+ (NSArray *)imageNames {
    
    return @[@"Mail.png", @"Star.png", @"PriceTag.png", @"LogOut.png"];
}


@end
