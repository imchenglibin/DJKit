//
//  DJMembersViewController.m
//  DJKit
//
//  Created by admin on 2017/3/4.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "DJMembersViewController.h"

@interface DJMembersViewController () <DJSegmentViewControllerDataSource>

@end

@implementation DJMembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -DJSegmentViewControllerDataSource

- (NSUInteger)totalSegmentCount {
    return 2;
}

- (UIViewController*)controllerAtIndex:(NSUInteger)index {
    return [[UIViewController alloc] init];
}

- (NSString*)segmentTitleAtIndex:(NSUInteger)index {
    NSArray *items = @[@"我的会员", @"待认领会员"];
    return [items objectAtIndex:index];
}

- (NSUInteger)segmentBadgeNumberAtIndex:(NSUInteger)index {
    return 0;
}

@end
