//
//  PhotoController.m
//  Milestons
//
//  Created by Dalton on 5/2/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "PhotoController.h"
#import "Photo.h"
#import "Entry.h"


@implementation PhotoController

+ (PhotoController *)sharedInstance {
    static PhotoController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PhotoController alloc] init];
        [sharedInstance loadPhotosFromParse];
    });
    return sharedInstance;
}

#pragma mark - Create

// Needs to pass in the location of the photo on the device
- (void)createPhoto {
    
    Photo *photo = [Photo object];
    
    [photo pinInBackground];
    [photo saveInBackground];
    
}


#pragma mark - Read

- (void)loadPhotosFromParse {
    
    PFQuery *query = [Photo query];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (Photo *photo in objects) {
            [photo pinInBackground];
        }
    }];
}

- (void)loadThesePhotosFromParse {
    
    
    PFQuery *photoQuery = [Photo query];
    
    Photo *myPhoto = [Photo new];
    
    Entry *myEntry = [Entry new];
    
    myPhoto.entry = myEntry;
    
    [photoQuery whereKey:@"entry" equalTo:myEntry];
    
    [photoQuery findObjectsInBackground];

    [myEntry pinInBackground];
    
}


- (NSArray *)photos {
    
    PFQuery *query = [Photo query];
    [query fromLocalDatastore];
    return [query findObjects];
    
}


#pragma mark - Update

- (void)updatePhoto:(Photo *)photo {
    
    [photo pinInBackground];
    [photo saveInBackground];
    
}

#pragma mark - Delete

- (void)removePhoto:(Photo *)photo {
    
    [photo unpinInBackground];
    [photo deleteInBackground];
}


@end
