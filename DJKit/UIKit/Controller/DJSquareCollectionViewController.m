//
//  DJSquareCollectionViewController.m
//  DJKit
//
//  Created by 紫藤 on 2017/3/3.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "DJSquareCollectionViewController.h"

#define DEFAULT_HEADER_VIEW_HEIGHT 120

@implementation DJSquareCollectionViewController

#pragma mark -life cycle

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _squareCollectionView = [[DJSquareCollectionView alloc] init];
    [self.view addSubview:_squareCollectionView];
    _headerViewHeight = DEFAULT_HEADER_VIEW_HEIGHT;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!self.headerView || self.headerViewHeight == 0) {
        self.squareCollectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        self.squareCollectionView.contentInset = UIEdgeInsetsMake([self calTopShifting], 0, [self calBottomShift], 0);
    } else {
        CGFloat viewWidth = self.view.frame.size.width;
        CGFloat viewHeight = self.view.frame.size.height;
        CGFloat top = [self calTopShifting];
        CGFloat bottom = [self calBottomShift];
        self.headerView.frame = CGRectMake(0, top, viewWidth, self.headerViewHeight);
        self.squareCollectionView.frame = CGRectMake(0, top + self.headerViewHeight, viewWidth, viewHeight - self.headerViewHeight - top);
        self.squareCollectionView.contentInset = UIEdgeInsetsMake(0, 0, bottom, 0);
    }
}

- (CGFloat)calTopShifting {
    if (!([self.parentViewController isKindOfClass:[UITabBarController class]] || [self.parentViewController isKindOfClass:[UINavigationController class]])) {
        return 0;
    }

    if (self.navigationController && self.automaticallyAdjustsScrollViewInsets && self.navigationController.navigationBar.isHidden == NO) {
        if (self.navigationController.navigationBar.translucent) {
            CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
            CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
            return statusBarHeight + navigationBarHeight;
        }
    }
    return 0;
}

- (CGFloat)calBottomShift {
    if (!([self.parentViewController isKindOfClass:[UITabBarController class]] || [self.parentViewController isKindOfClass:[UINavigationController class]])) {
        return 0;
    }

    if (self.tabBarController && self.automaticallyAdjustsScrollViewInsets && self.tabBarController.tabBar.translucent) {
        return self.tabBarController.tabBar.frame.size.height;
    }
    return 0;
}

#pragma mark -properties

- (id<DJSquareCollectionViewDelegate>)delegate {
    return self.squareCollectionView.squareCollectionViewDelegate;
}

- (void)setDelegate:(id<DJSquareCollectionViewDelegate>)delegate {
    self.squareCollectionView.squareCollectionViewDelegate = delegate;
}

- (id<DJSquareCollectionViewDataSource>)dataSource {
    return self.squareCollectionView.squareCollectionViewDataSource;
}

- (void)setDataSource:(id<DJSquareCollectionViewDataSource>)dataSource {
    self.squareCollectionView.squareCollectionViewDataSource = dataSource;
}

- (void)setHeaderView:(UIView *)headerView {
    if (_headerView) {
        [_headerView removeFromSuperview];
    }
    _headerView = headerView;
    [self.view addSubview:_headerView];
    [self.view setNeedsLayout];
}

@end
