//
//  DJHomeViewController.m
//  DJKit
//
//  Created by 紫藤 on 2017/3/4.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "DJHomeViewController.h"

#import <UIImageView+AFNetworking.h>
#import <UIButton+AFNetworking.h>

#import "DJHomeHeaderView.h"
#import "DJHomeViewModel.h"
#import "DJBinderAndObserver.h"
#import "DJDefines.h"
#import "UIViewController+HUD.h"
#import "UIButton+DJCommand.h"

@interface DJHomeViewController () <DJSquareCollectionViewDataSource, DJSquareCollectionViewDelegate>
@property (nonatomic, strong) DJHomeHeaderView *homeHeaderView;
@property (nonatomic, strong) DJHomeViewModel *viewModel;
@property (nonatomic, strong) DJObserver *userInfoModelObserver;
@property (nonatomic, strong) DJObserver *squareItemsObserver;
@end

@implementation DJHomeViewController

- (instancetype)init {
    if (self = [super init]) {
        self.dataSource = self;
        self.delegate = self;
        self.headerView = self.homeHeaderView;
        self.headerViewHeight = [UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width - 64 - 48;

        [self observersAndBinders];
        [self loadDefault];
    }
    return self;
}

- (void)observersAndBinders {
    (void)self.userInfoModelObserver;
    (void)self.squareItemsObserver;
}

- (void)loadDefault {
    DJWeakify(self);
    [self dj_startLoading];
    [self.viewModel loadDefault:^{
        DJStrongify(self);
        [self dj_endLoading];
    } error:^(NSString *errorCode, NSString *errorMessage) {
        DJStrongify(self);
        [self dj_endLoading];
        [self dj_toastWithText:errorMessage];
    }];
}

#pragma mark -DJSquareCollectionViewDataSource

//每行square个数
- (NSUInteger)squareCountPerRow {
    return 3;
}

//square总数
- (NSUInteger)totalSqures {
    return [self.viewModel.squareItems count];
}

//第index个square的标题
- (NSString*)titleAtIndex:(NSUInteger)index {
    return [[self.viewModel.squareItems objectAtIndex:index] objectForKey:@"title"];
}

//第index个square的图片
- (UIImage*)imageAtIndex:(NSUInteger)index {
    NSString *icon = [[self.viewModel.squareItems objectAtIndex:index] objectForKey:@"icon"];
    return [UIImage imageNamed:icon];
}

#pragma mark -DJSquareCollectionViewDelegate

//点击第index个square
- (void)selectAtIndex:(NSUInteger)index {
    NSLog(@"点击第%@个square", @(index));
}

#pragma mark -getter and setter

- (DJHomeViewModel*)viewModel {
    if (!_viewModel) {
        _viewModel = [[DJHomeViewModel alloc] init];
    }
    return _viewModel;
}

- (DJObserver*)userInfoModelObserver {
    if (!_userInfoModelObserver) {
        DJWeakify(self);
        _userInfoModelObserver = [DJObserver observerForObject:self.viewModel
                                                       keyPath:@"userInfoModel"
                                                         block:^{
                                                             DJStrongify(self);
                                                             [self updateHeadView];
                                                         }];
    }
    return _userInfoModelObserver;
}

//更新头部UI
- (void)updateHeadView {
    DJHomeHeaderView *headView = (DJHomeHeaderView*)(self.headerView);
    [headView.avatarButton setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:self.viewModel.userInfoModel.avatar]];
    headView.userInfoLabel.text = self.viewModel.userInfoModel.userName;
    headView.companyInfoLabel.text = self.viewModel.userInfoModel.companyName;
}

- (DJObserver*)squareItemsObserver {
    if (!_squareItemsObserver) {
        DJWeakify(self);
        _squareItemsObserver = [DJObserver observerForObject:self.viewModel
                                                     keyPath:@"squareItems"
                                                       block:^{
                                                           DJStrongify(self);
                                                           [self.squareCollectionView reloadData];
                                                       }];
    }
    return _squareItemsObserver;
}

- (DJHomeHeaderView*)homeHeaderView {
    if (!_homeHeaderView) {
        _homeHeaderView = [DJHomeHeaderView homeHeaderView];
        DJWeakify(self);
        _homeHeaderView.avatarButton.dj_command = [[DJCommand alloc] initWithBlock:^{
            DJStrongify(self);
            [self clickAvatar];
        }];
    }
    return _homeHeaderView;
}

- (void)clickAvatar {
    NSLog(@"点击头像");
}

@end
