//
//  XTBinder.m
//  ReactiveCocoaDemo
//
//  Created by 紫藤 on 2017/3/6.
//  Copyright © 2017年 imchenglibin. All rights reserved.
//

#import "DJBinder.h"
#import "DJObserver.h"

@implementation DJBinder {
    DJObserver *_observer;
}

- (id)initForBindingFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
                      toObject:(id)toObject keyPath:(NSString *)toKeyPath
           transformationBlock:(DJBinderTransformationBlock)transformationBlock {
    if((self = [super init])) {
        __weak id wToObject = toObject;
        NSString *myToKeyPath = [toKeyPath copy];

        DJObserverBlockWithChangeDictionary changeBlock;
        if(transformationBlock) {
            changeBlock = [^(NSDictionary *change) {
                [wToObject setValue:transformationBlock(change[NSKeyValueChangeNewKey])
                         forKeyPath:myToKeyPath];
            } copy];
        } else {
            changeBlock = [^(NSDictionary *change) {
                [wToObject setValue:change[NSKeyValueChangeNewKey]
                         forKeyPath:myToKeyPath];
            } copy];
        }

        _observer = [DJObserver observerForObject:fromObject
                                          keyPath:fromKeyPath
                                          options:NSKeyValueObservingOptionNew
                                      changeBlock:changeBlock];
    }
    return self;
}

- (void)stopBinding {
    [_observer stopObserving];
    _observer = nil;
}

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath {
    return [[self alloc] initForBindingFromObject:fromObject keyPath:fromKeyPath
                                         toObject:toObject keyPath:toKeyPath
                              transformationBlock:nil];
}

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath
      valueTransformer:(NSValueTransformer *)valueTransformer {
    return [[self alloc] initForBindingFromObject:fromObject keyPath:fromKeyPath
                                         toObject:toObject keyPath:toKeyPath
                              transformationBlock:^id(id value) {
                                  return [valueTransformer transformedValue:value];
                              }];
}

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath
   transformationBlock:(DJBinderTransformationBlock)transformationBlock {
    return [[self alloc] initForBindingFromObject:fromObject keyPath:fromKeyPath
                                         toObject:toObject keyPath:toKeyPath
                              transformationBlock:transformationBlock];
}

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath toObject:(id)toObject keyPath:(NSString *)toKeyPath formatter:(NSFormatter *)formatter {
    return [[self alloc] initForBindingFromObject:fromObject keyPath:fromKeyPath
                                         toObject:toObject keyPath:toKeyPath
                              transformationBlock:^id(id value) {
                                  return [formatter stringForObjectValue: value];
                              }];
}

@end
