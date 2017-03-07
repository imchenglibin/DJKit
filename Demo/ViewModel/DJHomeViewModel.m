//
//  DJHomeViewModel.m
//  DJKit
//
//  Created by 紫藤 on 2017/3/6.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "DJHomeViewModel.h"

#import "DJDefines.h"
#import "DJAPIManager.h"

@implementation DJHomeViewModel

- (void)loadDefault:(void(^)())success
              error:(void(^)(NSString *errorCode, NSString *errorMessage))error {

    self.squareItems = @[
                         @{@"title" : @"查库存", @"icon" : @"Home_CheckStock"},
                         @{@"title" : @"收单", @"icon" : @"Home_Receive"},
                         @{@"title" : @"导购码", @"icon" : @"Home_RQCode"},
                         @{@"title" : @"订单", @"icon" : @"Home_Orders"},
                         @{@"title" : @"商品", @"icon" : @"Home_Goods"},
                         @{@"title" : @"爱分享", @"icon" : @"Home_Share"},
                         @{@"title" : @"活动", @"icon" : @"Home_Activity"},
                         @{@"title" : @"评价", @"icon" : @"Home_Comments"},
                         @{@"title" : @"业绩", @"icon" : @"Home_Achievement"}
                         ];

    DJWeakify(self);
    [[DJAPIManager defaultManager] getUserInfo:^(DJUserInfoModel *model) {
        DJStrongify(self);
        self.userInfoModel = model;
        success();
    } failure:error];
}

@end
