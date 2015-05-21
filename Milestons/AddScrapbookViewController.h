//
//  AddScrapbookViewController.h
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scrapbook.h"
#import "ScrapbookController.h"

@interface AddScrapbookViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    
        UIImage *finalImage;
}

@property (strong, nonatomic) Scrapbook *scrapbook;

-(void)updateWithScrapbook:(Scrapbook *)scrapbook andPhoto:(UIImage *)myImage;

@end
