//
//  EntryListViewDataSource.h
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
//#import "ScrapbookController.h"
@import MilestonesKit;

@interface EntryListViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *entries;

@end
