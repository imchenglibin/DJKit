//
//  DJMeViewController.m
//  DJKit
//
//  Created by admin on 2017/3/7.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "DJMeViewController.h"

#import <Masonry.h>
#import <UIImageView+AFNetworking.h>

#import "DJMeViewModel.h"
#import "DJObserver.h"
#import "DJDefines.h"
#import "UIViewController+HUD.h"
#import "UIViewController+DJImagePicker.h"
#import "UIViewController+MMPopupView.h"

@interface __DJTableViewCell : UITableViewCell
@end

@implementation __DJTableViewCell
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.imageView) {
        CGPoint center = self.imageView.center;
        CGFloat size = self.imageView.bounds.size.width - 20;
        self.imageView.frame = CGRectMake(center.x - size * .5, center.y - size * .5, size, size);
    }
}
@end

@interface DJMeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DJMeViewModel *viewModel;
@property (nonatomic, strong) DJObserver *tableViewItemsObserver;
@end


@implementation DJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];

    DJWeakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        DJStrongify(self);
        make.edges.equalTo(self.view);
    }];

    [self observersAndBinders];

    [self loadDefault];
}

- (void)loadDefault {
    DJWeakify(self);
    [self dj_startLoading];
    [self.viewModel loadDefault:^{
        DJStrongify(self);
        [self dj_endLoading];
    } error:^(NSString *errorCode, NSString *errorMessage) {
        DJStrongify(self);
        [self dj_endLoading];
        [self dj_toastWithText:errorMessage];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observersAndBinders {
    (void)self.tableViewItemsObserver;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = [[self.viewModel.tableViewItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    return [[item objectForKey:@"height"] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = [[self.viewModel.tableViewItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    switch ((DJMeTableViewCellActionType)[[item objectForKey:@"action"] integerValue]) {
        case DJMeTableViewCellActionTypeChangeAvatar:
            [self changeAvatar];
            break;
        case DJMeTableViewCellActionTypeChangeName:
            [self changeName];
            break;
        case DJMeTableViewCellActionTypeChangeGender:
            [self changeGender];
            break;
        case DJMeTableViewCellActionTypeChangePhoneNumber:
            [self changePhoneNumber];
            break;
        case DJMeTableViewCellActionTypeSetting:
            [self settting];
            break;
        case DJMeTableViewCellActionTypeLogout:
            [self logout];
            break;
        default:
            break;
    }
}

- (void)changeAvatar {
    [self.navigationController dj_showImagePicker:^(UIImage *image) {

    }];
}

- (void)settting {

}

- (void)logout {

}

- (void)changeName {
    //need to do nothing
}

- (void)changeGender {
    [self.navigationController dj_actionSheetWithTitle:@"性别选择" items:@[@"男", @"女"] block:^(NSInteger index) {
    }];
}

- (void)changePhoneNumber {

}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.tableViewItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.viewModel.tableViewItems objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = [[self.viewModel.tableViewItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@", @(indexPath.section)]];
    if (!cell) {
        cell = [[__DJTableViewCell alloc] initWithStyle:[[item objectForKey:@"style"] integerValue] reuseIdentifier:[NSString stringWithFormat:@"%@", @(indexPath.section)]];
    }
    NSString *image = [item objectForKey:@"image"];
    if (image.length > 0) {
        [cell.imageView setImageWithURL:[NSURL URLWithString:image]];
        cell.imageView.clipsToBounds = YES;
        cell.imageView.layer.cornerRadius = [[item objectForKey:@"height"] integerValue] / 2 - 10;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [item objectForKey:@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = [item objectForKey:@"subTitle"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.accessoryType = [[item objectForKey:@"accessStyle"] integerValue];
    return cell;
}

#pragma mark -getter and setter

- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (DJMeViewModel*)viewModel {
    if (!_viewModel) {
        _viewModel = [[DJMeViewModel alloc] init];
    }
    return _viewModel;
}

- (DJObserver*)tableViewItemsObserver {
    if (!_tableViewItemsObserver) {
        DJWeakify(self);
        _tableViewItemsObserver = [DJObserver observerForObject:self.viewModel keyPath:@"tableViewItems" block:^{
            DJStrongify(self);
            [self updateTableView];
        }];
    }
    return _tableViewItemsObserver;
}

- (void)updateTableView {
    [self.tableView reloadData];
}

@end
