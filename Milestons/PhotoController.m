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

@interface PhotoController()

@property (nonatomic, strong) NSArray *photos;

@end


@implementation PhotoController

+ (PhotoController *)sharedInstance {
    static PhotoController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PhotoController alloc] init];
        [sharedInstance loadThesePhotosFromParse:^(NSError *error) {
            // Nothing
        }];
    });
    return sharedInstance;
}

#pragma mark - Create

// Needs to pass in the location of the photo in the file system
- (void)createPhoto {
    
    Photo *photo = [Photo object];
    
    PFUser *user = [PFUser currentUser];
    photo.user = user;
    photo.ACL = [PFACL ACLWithUser:user];

    
//    [photo pinInBackground];
    [photo saveInBackground];
    
    NSMutableArray *mutablePhotos = [NSMutableArray arrayWithArray:self.photos];
    [mutablePhotos insertObject:photo atIndex:0];
    self.photos = mutablePhotos;
}


#pragma mark - Read


- (void)loadThesePhotosFromParse:(void (^)(NSError *error))completion {
    
    NSLog(@"Loading photos from Parse");
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    
    PFUser *user = [PFUser currentUser];
    [query whereKey:@"user" equalTo:user];
    
//    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            self.photos = objects;
            completion(nil);
        } else {
            completion(error);
        }
    }];
    
}


#pragma mark - Update

- (void)updatePhoto:(Photo *)photo {
    
//    [photo pinInBackground];
    [photo saveInBackground];
    
}

#pragma mark - Delete

- (void)removePhoto:(Photo *)photo {
    
    NSMutableArray *mutablePhotos = [NSMutableArray arrayWithArray:self.photos];
    [mutablePhotos removeObject:photo];
    self.photos = mutablePhotos;
    
//    [photo unpinInBackground];
    [photo deleteInBackground];
}


@end
