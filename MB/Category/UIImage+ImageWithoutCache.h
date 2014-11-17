//
//  UIImage+ImageWithoutCache.h
//  ButtonTest
//
//  Created by Tongtong Xu on 14-10-27.
//  Copyright (c) 2014年 Beijing Zhixun Innovation Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageWithoutCache)

+ (UIImage *)bt_imageWithBundleName:(NSString *)bundleName filepath:(NSString *)filepath imageName:(NSString *)imageName;

+ (UIImage *)bt_imageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName;

@end
