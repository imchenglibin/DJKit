//
//  UIViewController+(DJImagePicker).h
//  DJKit
//
//  Created by admin on 2017/3/7.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(DJImagePicker)

- (void)dj_showImagePicker:(void(^)(UIImage *))complete;

@end
