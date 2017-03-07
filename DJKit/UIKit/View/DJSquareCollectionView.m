//
//  DJSquareCollectionView.m
//  DJKit
//
//  Created by 紫藤 on 2017/3/3.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "DJSquareCollectionView.h"

#import "DJSquareCollectionViewCell.h"

#define SQUARE_COLLECTION_MARGIN 5

@interface DJSquareCollectionView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation DJSquareCollectionView

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:layout]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    UICollectionViewFlowLayout *myLayout = [[UICollectionViewFlowLayout alloc] init];
    if (self = [super initWithFrame:frame collectionViewLayout:myLayout]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *myLayout = [[UICollectionViewFlowLayout alloc] init];
    if (self = [super initWithFrame:frame collectionViewLayout:myLayout]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:layout]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    UINib *nib = [UINib nibWithNibName:@"DJSquareCollectionViewCell" bundle:nil];
    [self registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([DJSquareCollectionViewCell class])];
    self.dataSource = self;
    self.delegate = self;
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

#pragma mark -UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.squareCollectionViewDelegate selectAtIndex:indexPath.row];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:.9 alpha:.5];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.squareCollectionViewDataSource totalSqures];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DJSquareCollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DJSquareCollectionViewCell class]) forIndexPath:indexPath];
    [cell.imageView setImage:[self.squareCollectionViewDataSource imageAtIndex:indexPath.row]];
    [cell.titleLabel setText:[self.squareCollectionViewDataSource titleAtIndex:indexPath.row]];
    return cell;
}

#pragma mark -UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int width = (self.frame.size.width - ([self.squareCollectionViewDataSource squareCountPerRow] + 1) * SQUARE_COLLECTION_MARGIN) / [self.squareCollectionViewDataSource squareCountPerRow];
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(SQUARE_COLLECTION_MARGIN, SQUARE_COLLECTION_MARGIN, SQUARE_COLLECTION_MARGIN, SQUARE_COLLECTION_MARGIN);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return SQUARE_COLLECTION_MARGIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return SQUARE_COLLECTION_MARGIN;
}

@end
