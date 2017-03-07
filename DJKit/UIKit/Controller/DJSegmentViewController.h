//
//  DJSegmentViewController.h
//  DJKit
//
//  Created by admin on 2017/3/4.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DJSegmentViewControllerDataSource <NSObject>

- (NSUInteger)totalSegmentCount;

- (UIViewController*)controllerAtIndex:(NSUInteger)index;

- (NSString*)segmentTitleAtIndex:(NSUInteger)index;

- (NSUInteger)segmentBadgeNumberAtIndex:(NSUInteger)index;

@end

@interface DJSegmentViewController : UIViewController

@property (nonatomic, strong, readonly) UISegmentedControl *segmentedControl;

@property (nonatomic, weak) id<DJSegmentViewControllerDataSource> dataSource;

@end
