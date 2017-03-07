//
//  XTObserver.h
//  ReactiveCocoaDemo
//
//  Created by 紫藤 on 2017/3/6.
//  Copyright © 2017年 imchenglibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJObserver : NSObject

typedef void(^DJObserverBlock)(void);
typedef void(^DJObserverBlockWithOldAndNew)(id oldValue, id newValue);
typedef void(^DJObserverBlockWithChangeDictionary)(NSDictionary *change);

+ (instancetype)observerForObject:(id)object
                          keyPath:(NSString *)keyPath
                            block:(DJObserverBlock)block;

+ (instancetype)observerForObject:(id)object
                          keyPath:(NSString *)keyPath
                   oldAndNewBlock:(DJObserverBlockWithOldAndNew)block;

+ (instancetype)observerForObject:(id)object
                          keyPath:(NSString *)keyPath
                          options:(NSKeyValueObservingOptions)options
                      changeBlock:(DJObserverBlockWithChangeDictionary)block;

- (void)stopObserving;
@end
