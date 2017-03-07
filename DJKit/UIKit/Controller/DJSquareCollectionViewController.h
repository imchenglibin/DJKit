//
//  DJSquareCollectionViewController.h
//  DJKit
//
//  Created by 紫藤 on 2017/3/3.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DJSquareCollectionView.h"

@interface DJSquareCollectionViewController : UIViewController

@property (nonatomic, weak) id<DJSquareCollectionViewDelegate> delegate;

@property (nonatomic, weak) id<DJSquareCollectionViewDataSource> dataSource;

@property (nonatomic, strong, readonly) DJSquareCollectionView *squareCollectionView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, assign) CGFloat headerViewHeight;

@end
