//
//  DJUserInfoModel.h
//  DJKit
//
//  Created by 紫藤 on 2017/3/6.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJUserInfoModel : NSObject
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, assign) NSInteger gender;//0 男 1 女
@property (nonatomic, copy) NSString *position;

- (instancetype)initWithAvatar:(NSString*)avatar
                      userName:(NSString*)userName
                   companyName:(NSString*)companyName;

+ (instancetype)userInfoWithAvatar:(NSString*)avatar
                          userName:(NSString*)userName
                       companyName:(NSString*)companyName;
@end
