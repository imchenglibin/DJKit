//
//  DJSquareCollectionView.h
//  DJKit
//
//  Created by 紫藤 on 2017/3/3.
//  Copyright © 2017年 dianjia. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol DJSquareCollectionViewDataSource <NSObject>
//每行square个数
- (NSUInteger)squareCountPerRow;

//square总数
- (NSUInteger)totalSqures;

//第index个square的标题
- (NSString*)titleAtIndex:(NSUInteger)index;

//第index个square的图片
- (UIImage*)imageAtIndex:(NSUInteger)index;

@end

@protocol DJSquareCollectionViewDelegate <NSObject>

//点击第index个square
- (void)selectAtIndex:(NSUInteger)index;

@end

@interface DJSquareCollectionView : UICollectionView
@property (nonatomic, weak) id<DJSquareCollectionViewDelegate> squareCollectionViewDelegate;
@property (nonatomic, weak) id<DJSquareCollectionViewDataSource> squareCollectionViewDataSource;
@end
