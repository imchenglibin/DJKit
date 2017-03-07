//
//  DJHomeViewModel.h
//  DJKit
//
//  Created by 紫藤 on 2017/3/6.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DJUserInfoModel.h"

@interface DJHomeViewModel : NSObject

@property (nonatomic, strong) DJUserInfoModel *userInfoModel;

@property (nonatomic, strong) NSArray *squareItems;

- (void)loadDefault:(void(^)())success
              error:(void(^)(NSString *errorCode, NSString *errorMessage))error;

@end
