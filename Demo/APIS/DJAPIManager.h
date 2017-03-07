//
//  APIManager.h
//  DJKit
//
//  Created by 紫藤 on 2017/3/6.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJUserInfoModel.h"

typedef void(^DJAPIFailure)(NSString *errorCode, NSString *errorMessage);

@interface DJAPIManager : NSObject

+ (instancetype)defaultManager;

//获取用户信息
- (void)getUserInfo:(void(^)(DJUserInfoModel *))success failure:(DJAPIFailure)failure;

@end
