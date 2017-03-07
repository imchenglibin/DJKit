//
//  XTBinder.h
//  ReactiveCocoaDemo
//
//  Created by 紫藤 on 2017/3/6.
//  Copyright © 2017年 imchenglibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJBinder : NSObject

typedef id(^DJBinderTransformationBlock)(id value);

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath;

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath
      valueTransformer:(NSValueTransformer *)valueTransformer;

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath
             formatter:(NSFormatter *)formatter;

+ (id)binderFromObject:(id)fromObject keyPath:(NSString *)fromKeyPath
              toObject:(id)toObject keyPath:(NSString *)toKeyPath
   transformationBlock:(DJBinderTransformationBlock)transformationBlock;

- (void)stopBinding;

@end
