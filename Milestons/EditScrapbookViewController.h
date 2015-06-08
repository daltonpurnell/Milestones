//
//  EditEntryViewController.h
//  Milestons
//
//  Created by Dalton on 6/8/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scrapbook.h"
#import "ScrapbookController.h"
@import iAd;

@interface EditScrapbookViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, ADBannerViewDelegate> {
    ADBannerView *adView;
    UIImage *finalImage;
}

@property (strong, nonatomic) Scrapbook *scrapbook;

@property (strong, nonatomic)IBOutlet ADBannerView *adView;


-(void)updateWithScrapbook:(Scrapbook *)scrapbook;

@end
