//
//  UIButton+DJCommand.m
//  DJKit
//
//  Created by 紫藤 on 2017/3/7.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "UIButton+DJCommand.h"

#import <objc/message.h>

@implementation DJCommand {
    dispatch_block_t _block;
}

- (instancetype)initWithBlock:(dispatch_block_t)block {
    if (self = [super init]) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke {
    if (_block) {
        _block();
    }
}

@end

@implementation UIButton(DJCommand)

@dynamic dj_command;

- (DJCommand*)dj_command {
    return objc_getAssociatedObject(self, @selector(dj_command));
}

- (void)setDj_command:(DJCommand *)dj_command {
    if (self.dj_command) {
        [self removeTarget:self action:@selector(dj_command_selector:) forControlEvents:UIControlEventTouchUpInside];
    }
    objc_setAssociatedObject(self, @selector(dj_command), dj_command, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(dj_command_selector:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dj_command_selector:(id)sender {
    if (self.dj_command) {
        [self.dj_command performSelector:@selector(invoke)];
    }
}

@end
