//
//  DJHttpClient.m
//  DJKit
//
//  Created by admin on 2017/3/7.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "DJHttpClient.h"

#import <AFNetworking.h>

const NSString *kDJHttpClientNetWorkingReachabilityNotification = @"com.mugua.dian+.DJHttpClient.kDJHttpClientNetWorkingReachabilityNotification";

const NSString *kDJHttpClientAuthErrorNotification = @"com.mugua.dian+.DJHttpClient.kDJHttpClientAuthErrorNotification";

typedef NS_ENUM(NSInteger, DJRequestMethod) {
    DJRequestMethodPost = 0,
    DJRequestMethodGet = 1
};

typedef void (^AFSuccess)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);

typedef void (^AFFailure)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);

@implementation DJHttpClient

+ (instancetype)defaultClient {
    static dispatch_once_t onceToken;
    static DJHttpClient *instance;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        [instance startNetworkReachabilityMonitoring];
    });
    return instance;
}

- (void)startNetworkReachabilityMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                [center postNotificationName:(NSString*)kDJHttpClientNetWorkingReachabilityNotification
                                      object:nil
                                    userInfo:@{@"message": @"你已经进入无网络的异次元世界"}];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [center postNotificationName:(NSString*)kDJHttpClientNetWorkingReachabilityNotification
                                      object:nil
                                    userInfo:@{@"message": @"你已经链接WIFI"}];
                break;
            default:
                break;
        }
    }];
}

//http post
- (void)post:(NSString *)url
  parameters:(NSDictionary *)parameters
     headers:(NSDictionary *)headers
     success:(DJHttpClientRequestSuccess)success
     failure:(DJHttpClientRequestFailure)failure {
    [self request:DJRequestMethodPost
              url:url
       parameters:parameters
          headers:headers
          success:success
          failure:failure];
}

//http get
- (void)get:(NSString *)url
 parameters:(NSDictionary *)parameters
    headers:(NSDictionary *)headers
    success:(DJHttpClientRequestSuccess)success
    failure:(DJHttpClientRequestFailure)failure {
    [self request:DJRequestMethodGet
              url:url
       parameters:parameters
          headers:headers
          success:success
          failure:failure];
}

- (void)request:(DJRequestMethod)method
            url:(NSString *)url
     parameters:(NSDictionary *)parameters
        headers:(NSDictionary *)headers
        success:(DJHttpClientRequestSuccess)success
        failure:(DJHttpClientRequestFailure)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (headers) {
        [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    AFSuccess afSuccess = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultCode = [responseObject objectForKey:@"resultCode"];
        if ([@"success" isEqualToString:resultCode]) {
            success([responseObject objectForKey:@"resultObject"]);
        } else {
            failure(resultCode, [responseObject objectForKey:@"exceptionMessage"]);
            if ([@"loginfailure" isEqualToString:resultCode]) {
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:(NSString*)kDJHttpClientAuthErrorNotification
                                      object:nil
                                    userInfo:@{}];
            }
        }
    };
    AFFailure afFailure= ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure([NSString stringWithFormat:@"%@", @(error.code)], @"网络请求错误");
    };
    NSURLSessionDataTask *sessionDataTask;
    if (DJRequestMethodGet == method) {
        sessionDataTask = [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:afSuccess failure:afFailure];
    } else if (DJRequestMethodPost == method) {
        sessionDataTask = [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:afSuccess failure:afFailure];
    }
}

@end
