//
//  DJSegmentViewController.m
//  DJKit
//
//  Created by admin on 2017/3/4.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "DJSegmentViewController.h"

#define HEADER_HEIGHT 50

#define MARGIN_TOP 10
#define MARGIN_BOTTOM MARGIN_TOP
#define MARGIN_LEFT 20
#define MARGIN_RIGHT MARGIN_LEFT

@interface DJSegmentViewController ()

@property (nonatomic, strong) UIView *container;

@property (nonatomic, strong) UIView *segmentedBackgroundView;

@end

@implementation DJSegmentViewController

#pragma mark -life cycle

@synthesize segmentedControl = _segmentedControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat top = [self calTopShifting];
    CGFloat bottom = [self calBottomShift];
    self.segmentedBackgroundView.frame = CGRectMake(0, top, self.view.bounds.size.width, HEADER_HEIGHT);
    self.segmentedControl.frame = CGRectMake(MARGIN_LEFT, top + MARGIN_TOP, self.view.bounds.size.width - MARGIN_LEFT - MARGIN_RIGHT, HEADER_HEIGHT - MARGIN_TOP - MARGIN_BOTTOM);
    self.container.frame = CGRectMake(0, top + HEADER_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height - top - bottom - HEADER_HEIGHT);
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

#pragma mark -response

- (void)segmentValueChanged:(UISegmentedControl*)control {

}

#pragma mark -properties

- (UISegmentedControl*)segmentedControl {
    if (!_segmentedControl) {
        NSUInteger total = [self.dataSource totalSegmentCount];
        NSMutableArray *items = [NSMutableArray array];
        for (NSUInteger i = 0; i < total; i++) {
            [items addObject:[self.dataSource segmentTitleAtIndex:i]];
        }
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:[items copy]];
        [_segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.tintColor = [UIColor colorWithRed:1.0 green:59.0 / 255 blue:74.0 / 255 alpha:1];
        [self.view addSubview:_segmentedControl];
    }
    return _segmentedControl;
}



- (UIView*)container {
    if (!_container) {
        _container = [[UIView alloc] init];
        [self.view addSubview:_container];
    }
    return _container;
}

- (UIView*)segmentedBackgroundView {
    if (!_segmentedBackgroundView) {
        _segmentedBackgroundView = [[UIView alloc] init];
        _segmentedBackgroundView.backgroundColor = [UIColor whiteColor];
        [self.view insertSubview:_segmentedBackgroundView atIndex:0];
    }
    return _segmentedBackgroundView;
}

@end
