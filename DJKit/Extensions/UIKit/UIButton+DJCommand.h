//
//  UIButton+DJCommand.h
//  DJKit
//
//  Created by 紫藤 on 2017/3/7.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJCommand : NSObject

- (instancetype)initWithBlock:(dispatch_block_t)block;

@end

@interface UIButton(DJCommand)

@property(nonatomic, strong) DJCommand *dj_command;

@end
