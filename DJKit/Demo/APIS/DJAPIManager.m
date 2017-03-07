//
//  APIManager.m
//  DJKit
//
//  Created by 紫藤 on 2017/3/6.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "DJAPIManager.h"

#import <AFNetworkReachabilityManager.h>

#import "DJHttpClient.h"

@implementation DJAPIManager

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    static DJAPIManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)getUserInfo:(void(^)(DJUserInfoModel *))success failure:(DJAPIFailure)failure {
    //模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[DJHttpClient defaultClient] get:@"http://localhost/test.php" parameters:@{} headers:@{} success:^(id responseObject) {
            NSString *avatar = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1140958647,2055517506&fm=116&gp=0.jpg";
            DJUserInfoModel *model = [DJUserInfoModel userInfoWithAvatar:avatar
                                                                userName:@"紫藤（程利斌）"
                                                             companyName:@"木瓜科技有限公司 杭州分公司"];
            model.phoneNumber = @"15088649587";
            model.gender = 0;
            model.position = @"店长";
            success(model);
        } failure:failure];
    });
}

@end
