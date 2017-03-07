//
//  DJHomeHeaderView.h
//  DJKit
//
//  Created by admin on 2017/3/4.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJHomeHeaderView : UIView

+ (instancetype)homeHeaderView;

@property (weak, nonatomic) IBOutlet UIButton *avatarButton;

@property (weak, nonatomic) IBOutlet UILabel *userInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyInfoLabel;

@end
