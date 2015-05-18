//
//  ScrapbookController.h
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scrapbook.h"

@interface ScrapbookController : NSObject

@property (strong, nonatomic, readonly) NSArray *scrapbooks;

+ (ScrapbookController *) sharedInstance;

- (void)loadScrapbooksFromParse:(void (^)(NSError *error))completion;
- (void)createScrapbookWithTitle: (NSString *) title date:(NSDate *)timestamp photo:(UIImage *)image;
- (void)updateScrapbook:(Scrapbook *)scrapbook;
- (void)removeScrapbook:(Scrapbook *)scrapbook;

@end
