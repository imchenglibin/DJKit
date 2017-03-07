//
//  UIViewController+HUD.h
//  DJKit
//
//  Created by 紫藤 on 2017/3/6.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(HUD)

- (void)dj_startLoading;

- (void)dj_endLoading;

- (void)dj_toastWithText:(NSString*)text;

- (void)dj_showCompleteToast;

@end
