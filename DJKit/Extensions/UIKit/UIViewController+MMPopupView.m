//
//  UIViewController+MMPopupView.m
//  DJKit
//
//  Created by 紫藤 on 2017/3/7.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "UIViewController+MMPopupView.h"

#import <MMPopupItem.h>
#import <MMAlertView.h>
#import <MMSheetView.h>

@interface UIViewController(MMPopupView_Private)

@end

@implementation UIViewController(MMPopupView)

- (void)dj_alertWithTitle:(NSString *)title {
    NSArray *items =
    @[MMItemMake(@"确定", MMItemTypeNormal, ^(NSInteger index) {
    })];
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"提示框"
                                 detail:title
                                  items:items];
    alertView.attachedView = self.view;
    [alertView show];
}

- (void)dj_comfirmWithTitle:(NSString *)title
                         ok:(dispatch_block_t)ok
                     cancel:(dispatch_block_t)cancel {

    dispatch_block_t okCopy = [ok copy];
    dispatch_block_t cancelCopy = [cancel copy];
    void(^block)(NSInteger index) = ^(NSInteger index) {
        if (index == 0) {
            okCopy();
        } else {
            cancelCopy();
        }
    };
    NSArray *items = @[MMItemMake(@"确定", MMItemTypeNormal, block),
                       MMItemMake(@"取消", MMItemTypeNormal, block)];
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"提示框"
                                                         detail:title
                                                          items:items];
    alertView.attachedView = self.view;
    alertView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    [alertView show];
}

- (void)dj_actionSheetWithTitle:(NSString *)title
                          items:(NSArray *)items
                          block:(void(^)(NSInteger))block {
    void(^blockCopy)(NSInteger) = [block copy];
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *item in items) {
        [array addObject:MMItemMake(item, MMItemTypeNormal, blockCopy)];
    }
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:title
                                                        items:array];
    sheetView.attachedView = self.view;
    sheetView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    [sheetView show];
}

@end
