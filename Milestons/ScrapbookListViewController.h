//
//  ScrapbookListViewController.h
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scrapbook.h"

@interface ScrapbookListViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *options;

@property (strong, nonatomic) Scrapbook *scrapbook;


@end
