//
//  XTObserver.m
//  ReactiveCocoaDemo
//
//  Created by 紫藤 on 2017/3/6.
//  Copyright © 2017年 imchenglibin. All rights reserved.
//

#import "DJObserver.h"

@implementation DJObserver {
    NSString *_keyPath;
    dispatch_block_t _block;
    __weak id _observedObject;
}

typedef enum DJObserverBlockArgumentsKind {
    DJObserverBlockArgumentsNone,
    DJObserverBlockArgumentsOldAndNew,
    DJObserverBlockArgumentsChangeDictionary
} DJObserverBlockArgumentsKind;


+ (instancetype)observerForObject:(id)object
                          keyPath:(NSString *)keyPath
                            block:(DJObserverBlock)block {
    return [[self alloc] initWithObject:object
                                keyPath:keyPath
                                options:0
                                  block:block
                     blockArgumentsKind:DJObserverBlockArgumentsNone];
}

+ (instancetype)observerForObject:(id)object
                          keyPath:(NSString *)keyPath
                   oldAndNewBlock:(DJObserverBlockWithOldAndNew)block {
    return [[self alloc] initWithObject:object
                                keyPath:keyPath
                                options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                                  block:(dispatch_block_t)block
                     blockArgumentsKind:DJObserverBlockArgumentsOldAndNew];
}

+ (instancetype)observerForObject:(id)object
                          keyPath:(NSString *)keyPath
                          options:(NSKeyValueObservingOptions)options
                      changeBlock:(DJObserverBlockWithChangeDictionary)block {
    return [[self alloc] initWithObject:object
                                keyPath:keyPath
                                options:options
                                  block:(dispatch_block_t)block
                     blockArgumentsKind:DJObserverBlockArgumentsChangeDictionary];
}

- (instancetype)initWithObject:(id)object
                       keyPath:(NSString *)keyPath
                       options:(NSKeyValueObservingOptions)options
                         block:(dispatch_block_t)block
            blockArgumentsKind:(DJObserverBlockArgumentsKind)blockArgumentsKind {

    if (self = [super init]) {
        if(!object || !keyPath || !block) {
            [NSException raise:NSInternalInconsistencyException format:@"Observation must have a valid object (%@), keyPath (%@) and block(%@)", object, keyPath, block];
            self = nil;
        } else {
            _observedObject = object;
            _keyPath = [keyPath copy];
            _block = [block copy];
            [_observedObject addObserver:self
                              forKeyPath:_keyPath
                                 options:options
                                 context:(void *)blockArgumentsKind];
        }
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    switch((DJObserverBlockArgumentsKind)context) {
        case DJObserverBlockArgumentsNone:
            ((DJObserverBlock)_block)();
            break;
        case DJObserverBlockArgumentsOldAndNew:
            ((DJObserverBlockWithOldAndNew)_block)(change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
            break;
        case DJObserverBlockArgumentsChangeDictionary:
            ((DJObserverBlockWithChangeDictionary)_block)(change);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"%s called on %@ with unrecognised context (%p)", __func__, self, context];
    }
}

- (void)dealloc {
    if(_observedObject) {
        [self stopObserving];
    }
}

- (void)stopObserving {
    [_observedObject removeObserver:self forKeyPath:_keyPath];
    _block = nil;
    _keyPath = nil;
    _observedObject = nil;
}


@end
