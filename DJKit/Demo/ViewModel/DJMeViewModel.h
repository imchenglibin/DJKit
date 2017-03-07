//
//  DJMeViewModel.h
//  DJKit
//
//  Created by admin on 2017/3/7.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DJMeTableViewCellActionType) {
    DJMeTableViewCellActionTypeChangeAvatar = 0,
    DJMeTableViewCellActionTypeChangeName,
    DJMeTableViewCellActionTypeChangeGender,
    DJMeTableViewCellActionTypeChangePhoneNumber,
    DJMeTableViewCellActionTypeSetting,
    DJMeTableViewCellActionTypeLogout
};

@interface DJMeViewModel : NSObject
@property (nonatomic, strong) NSArray *tableViewItems;

- (void)loadDefault:(void(^)())success
              error:(void(^)(NSString *errorCode, NSString *errorMessage))error;
@end
