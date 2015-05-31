//
//  CollectionViewDataSource.m
//  Milestons
//
//  Created by Dalton on 5/30/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "CollectionViewDataSource.h"
#import "PhotoController.h"
#import "EntryController.h"
#import "CustomCollectionViewCell.h"

@implementation CollectionViewDataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //create cell...
   CustomCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.entry.photos.count;
}

@end
