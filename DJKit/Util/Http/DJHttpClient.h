//
//  DJHttpClient.h
//  DJKit
//
//  Created by admin on 2017/3/7.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DJHttpClientRequestFailure)(NSString *error, NSString *errorMessage);

typedef void(^DJHttpClientRequestSuccess)(id responseObject);

extern const NSString *kDJHttpClientNetWorkingReachabilityNotification;
extern const NSString *kDJHttpClientAuthErrorNotification;

@interface DJHttpClient : NSObject

+ (instancetype)defaultClient;

//http post
- (void)post:(NSString *)url
  parameters:(NSDictionary *)parameters
     headers:(NSDictionary *)headers
     success:(DJHttpClientRequestSuccess)success
     failure:(DJHttpClientRequestFailure)failure;

//http get
- (void)get:(NSString *)url
 parameters:(NSDictionary *)parameters
    headers:(NSDictionary *)headers
    success:(DJHttpClientRequestSuccess)success
    failure:(DJHttpClientRequestFailure)failure;

@end
