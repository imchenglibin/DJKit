//
//  DJUserInfoModel.m
//  DJKit
//
//  Created by 紫藤 on 2017/3/6.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "DJUserInfoModel.h"

@implementation DJUserInfoModel

- (instancetype)initWithAvatar:(NSString *)avatar
                      userName:(NSString *)userName
                   companyName:(NSString *)companyName {
    if (self = [super init]) {
        _avatar = [avatar copy];
        _userName = [userName copy];
        _companyName = [companyName copy];
    }
    return self;
}

+ (instancetype)userInfoWithAvatar:(NSString *)avatar
                          userName:(NSString *)userName
                       companyName:(NSString *)companyName {
    return [[self alloc] initWithAvatar:avatar
                               userName:userName
                            companyName:companyName];
}

@end
