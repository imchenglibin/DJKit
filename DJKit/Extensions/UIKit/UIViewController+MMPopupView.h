//
//  UIViewController+MMPopupView.h
//  DJKit
//
//  Created by 紫藤 on 2017/3/7.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(MMPopupView)

- (void)dj_alertWithTitle:(NSString *)title;

- (void)dj_comfirmWithTitle:(NSString *)title
                         ok:(dispatch_block_t)ok
                     cancel:(dispatch_block_t)cancel;

- (void)dj_actionSheetWithTitle:(NSString *)title
                          items:(NSArray *)items
                          block:(void(^)(NSInteger))block;

@end
