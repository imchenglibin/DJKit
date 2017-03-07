//
//  DJMeViewModel.m
//  DJKit
//
//  Created by admin on 2017/3/7.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "DJMeViewModel.h"

#import <UIKit/UIKit.h>

#import "DJDefines.h"
#import "DJAPIManager.h"

@implementation DJMeViewModel

- (void)loadDefault:(void(^)())success
              error:(void(^)(NSString *errorCode, NSString *errorMessage))error {
    DJWeakify(self);
    [[DJAPIManager defaultManager] getUserInfo:^(DJUserInfoModel *model) {
        DJStrongify(self);

        self.tableViewItems = @[
                                @[[self makeItemWithTitle:model.position
                                                 subTitle:model.companyName
                                                    image:model.avatar
                                                    style:UITableViewCellStyleSubtitle
                                                   height:100
                                                   action:DJMeTableViewCellActionTypeChangeAvatar
                                              accessStyle:UITableViewCellAccessoryDisclosureIndicator]],

                                @[[self makeItemWithTitle:@"姓名"
                                                 subTitle:model.userName
                                                    image:@""
                                                    style:UITableViewCellStyleValue1
                                                   height:45
                                                   action:DJMeTableViewCellActionTypeChangeName
                                              accessStyle:UITableViewCellAccessoryNone],

                                  [self makeItemWithTitle:@"性别"
                                                 subTitle:model.gender == 0 ? @"男" : @"女"
                                                    image:@""
                                                    style:UITableViewCellStyleValue1
                                                   height:45
                                                   action:DJMeTableViewCellActionTypeChangeGender
                                              accessStyle:UITableViewCellAccessoryDisclosureIndicator],

                                  [self makeItemWithTitle:@"手机号"
                                                 subTitle:model.phoneNumber
                                                    image:@""
                                                    style:UITableViewCellStyleValue1
                                                   height:45
                                                   action:DJMeTableViewCellActionTypeChangePhoneNumber
                                              accessStyle:UITableViewCellAccessoryDisclosureIndicator]],

                                 @[[self makeItemWithTitle:@"设置"
                                                  subTitle:model.phoneNumber
                                                     image:@""
                                                     style:UITableViewCellStyleValue1
                                                    height:45
                                                    action:DJMeTableViewCellActionTypeSetting
                                               accessStyle:UITableViewCellAccessoryDisclosureIndicator]],

                                 @[[self makeItemWithTitle:@"退出登录"
                                                subTitle:model.phoneNumber
                                                   image:@""
                                                   style:UITableViewCellStyleDefault
                                                  height:45
                                                  action:DJMeTableViewCellActionTypeLogout
                                             accessStyle:UITableViewCellAccessoryNone]]
                                ];
        success();
    } failure:error];
}

- (NSDictionary*)makeItemWithTitle:(NSString*)title
                          subTitle:(NSString*)subTitle
                             image:(NSString*)image
                             style:(UITableViewCellStyle)style
                            height:(CGFloat)height
                            action:(DJMeTableViewCellActionType)action
                        accessStyle:(UITableViewCellAccessoryType)accessStyle {
    return @{@"title":title,
             @"subTitle":subTitle,
             @"image":image,
             @"style":@(style),
             @"height":@(height),
             @"action":@(action),
             @"accessStyle":@(accessStyle)};
}

@end
