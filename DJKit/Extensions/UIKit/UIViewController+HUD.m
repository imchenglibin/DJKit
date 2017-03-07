//
//  UIViewController+HUD.m
//  DJKit
//
//  Created by 紫藤 on 2017/3/6.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "UIViewController+HUD.h"

#import <objc/message.h>
#import <MBProgressHUD.h>

#import "DJDefines.h"

@interface UIViewController(HUD_Private)<MBProgressHUDDelegate>

@property(nonatomic,strong) MBProgressHUD *dj_loadingHUD;
@property(nonatomic, strong) MBProgressHUD *dj_toastHUD;
@property(nonatomic, strong) MBProgressHUD *dj_completeHUD;

@end

@implementation UIViewController(HUD_Private)

@dynamic dj_loadingHUD;
@dynamic dj_toastHUD;
@dynamic dj_completeHUD;

- (MBProgressHUD*)dj_loadingHUD {
    return objc_getAssociatedObject(self, @selector(dj_loadingHUD));
}

- (void)setDj_loadingHUD:(MBProgressHUD *)dj_loadingHUD {
    objc_setAssociatedObject(self, @selector(dj_loadingHUD), dj_loadingHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD*)dj_toastHUD {
    return objc_getAssociatedObject(self, @selector(dj_toastHUD));
}

- (void)setDj_toastHUD:(MBProgressHUD *)dj_toastHUD {
    objc_setAssociatedObject(self, @selector(dj_toastHUD), dj_toastHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD*)dj_completeHUD {
    return objc_getAssociatedObject(self, @selector(dj_completeHUD));
}

- (void)setDj_completeHUD:(MBProgressHUD *)dj_completeHUD {
    objc_setAssociatedObject(self, @selector(dj_completeHUD), dj_completeHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIViewController(HUD)

- (void)dj_startLoading {
    if (!self.dj_loadingHUD) {
        self.dj_loadingHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.dj_loadingHUD.mode = MBProgressHUDModeIndeterminate;
        self.dj_loadingHUD.contentColor = [UIColor whiteColor];
        self.dj_loadingHUD.label.textColor = [UIColor whiteColor];
        self.dj_loadingHUD.bezelView.backgroundColor = [UIColor colorWithWhite:.1 alpha:.6];
        self.dj_loadingHUD.label.text = @"正在加载数据";
        self.dj_loadingHUD.label.font = [UIFont systemFontOfSize:13];
    }
    [self.dj_loadingHUD showAnimated:YES];
}

- (void)dj_endLoading {
    [self.dj_loadingHUD hideAnimated:YES];
}

- (void)dj_toastWithText:(NSString*)text {
    if (!self.dj_toastHUD) {
        self.dj_toastHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.dj_toastHUD.mode = MBProgressHUDModeText;
        self.dj_toastHUD.contentColor = [UIColor whiteColor];
        self.dj_toastHUD.label.textColor = [UIColor whiteColor];
        self.dj_toastHUD.bezelView.backgroundColor = [UIColor colorWithWhite:.1 alpha:.6];
        self.dj_toastHUD.label.font = [UIFont systemFontOfSize:13];
    }
    self.dj_toastHUD.label.text = text;
    [self.dj_toastHUD showAnimated:YES];
    DJWeakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DJStrongify(self);
        [self.dj_toastHUD hideAnimated:YES];
    });
}

- (void)dj_showCompleteToast {
    if (!self.dj_completeHUD) {
        self.dj_completeHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.dj_completeHUD.mode = MBProgressHUDModeCustomView;
        self.dj_completeHUD.contentColor = [UIColor whiteColor];
        self.dj_completeHUD.bezelView.backgroundColor = [UIColor colorWithWhite:.1 alpha:.6];
        UIImage *image = [[UIImage imageNamed:@"hud_done"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.dj_completeHUD.customView = [[UIImageView alloc] initWithImage:image];
        // Looks a bit nicer if we make it square.
        //self.dj_completeHUD.square = YES;
        self.dj_completeHUD.label.font = [UIFont systemFontOfSize:13];
        self.dj_completeHUD.label.text = @"操作完成";
    }
    [self.dj_completeHUD showAnimated:YES];
    DJWeakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DJStrongify(self);
        [self.dj_completeHUD hideAnimated:YES];
    });
}

@end
