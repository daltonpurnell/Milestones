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
    });
    return sharedInstance;
}

#pragma mark - Create

- (void)createPhotoWithImage:(UIImage *)myPhoto inEntry:(Entry *)entry completion:(void (^)(BOOL succeeded, Photo *photo))completion {
    
    Photo *photo = [Photo object];
    
    PFFile *imageFile = [PFFile fileWithData:UIImageJPEGRepresentation(myPhoto,0.95)];
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            if (succeeded) {
                photo.picture = imageFile;

                PFUser *user = [PFUser currentUser];
                photo.user = user;
                photo.entry = entry;
                photo.ACL = [PFACL ACLWithUser:user];
                
                [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    completion(succeeded, photo);
                }];

            }else {
                NSLog(@"%@",error);
            }
        }
    }];
    

}


#pragma mark - Read


- (void)loadThesePhotosFromParseInEntry:(Entry *)entry completion:(void (^)(NSArray *photos, NSError *error))completion {
    
    NSLog(@"Loading photos from Parse");
    PFQuery *query = [Photo query];
    
    PFUser *user = [PFUser currentUser];
    [query whereKey:@"user" equalTo:user];
    [query whereKey:@"entry" equalTo:entry];
    
//    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            self.photos = objects;
            completion(objects, nil);
        } else {
            completion(nil, error);
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
    
//    [photo unpinInBackground];
    [photo deleteInBackground];
}


@end
