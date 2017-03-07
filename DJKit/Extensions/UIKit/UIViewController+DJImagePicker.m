//
//  UIViewController+(DJImagePicker).m
//  DJKit
//
//  Created by admin on 2017/3/7.
//  Copyright © 2017年 dianjia. All rights reserved.
//

#import "UIViewController+DJImagePicker.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import <AssetsLibrary/ALAsset.h>
#import <AVFoundation/AVFoundation.h>
#import <objc/message.h>

#import "UIViewController+MMPopupView.h"
#import "DJDefines.h"

@interface UIViewController(DJImagePicker_Private) <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) void(^dj_block)(UIImage*);

@end

@implementation UIViewController(DJImagePicker_Private)

@dynamic dj_block;

- (void(^)(UIImage*))dj_block {
    return objc_getAssociatedObject(self, @selector(dj_block));
}

- (void)setDj_block:(void (^)(UIImage *))dj_block {
    objc_setAssociatedObject(self, @selector(dj_block), dj_block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIViewController(DJImagePicker)

- (void)dj_showImagePicker:(void(^)(UIImage *))complete {
    self.dj_block = [complete copy];
    DJWeakify(self);
    [self dj_actionSheetWithTitle:@"图片选择"
                            items:@[@"拍照", @"从相册中读取"]
                            block:^(NSInteger index) {
                                DJStrongify(self);
                                [self dj_showImagePickerWithIndex:index];
                            }];
}

- (void)dj_showImagePickerWithIndex:(NSInteger)index {
    if (index == 0) {
        [self dj_showCamera];
    } if (index == 1) {
        [self dj_showPhotosLibrary];
    }
}

- (void)dj_showCamera {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        [self dj_alertWithTitle:@"请在iPhone的设置\"设置-隐私-相机\"选项中,允许店+访问你的相机。"];
    }

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        [self dj_alertWithTitle:@"未检测到摄像头"];
    }
}

- (void)dj_showPhotosLibrary {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark -UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (self.dj_block) {
        self.dj_block(image);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

@end
