//
//  DJHomeHeaderView.m
//  DJKit
//
//  Created by admin on 2017/3/4.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "DJHomeHeaderView.h"

@interface DJHomeHeaderView()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation DJHomeHeaderView

+ (instancetype)homeHeaderView {
    UINib *nib = [UINib nibWithNibName:@"DJHomeHeaderView" bundle:nil];
    DJHomeHeaderView *view = [[nib instantiateWithOwner:nil options:nil] firstObject];
    view.avatarButton.layer.cornerRadius = 30;
    view.avatarButton.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.6].CGColor;
    view.avatarButton.layer.borderWidth = 3;
    view.avatarButton.clipsToBounds = YES;
    view.userInfoLabel.textColor = [UIColor whiteColor];
    view.companyInfoLabel.textColor = [UIColor whiteColor];
    return view;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundImageView.frame = self.bounds;
}

#pragma mark -properties
- (UIImageView*)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_HeaderViewBackground"]];
        [self insertSubview:_backgroundImageView atIndex:0];
    }
    return _backgroundImageView;
}
@end
