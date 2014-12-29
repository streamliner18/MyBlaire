//
//  UIImage+ImageWithoutCache.m
//  ButtonTest
//
//  Created by Tongtong Xu on 14-10-27.
//  Copyright (c) 2014年 Beijing Zhixun Innovation Co. Ltd. All rights reserved.
//

#import "UIImage+ImageWithoutCache.h"

@implementation UIImage (ImageWithoutCache)

+ (UIImage *)bt_imageWithBundleName:(NSString *)bundleName filepath:(NSString *)filepath imageName:(NSString *)imageName
{
    if (imageName == nil) {
        return nil;
    }
    NSBundle *bundle = bundleName ? [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"]] : [NSBundle mainBundle];
    
    NSString *fullImageName;
    NSString *fullImageName2x;
    NSString *fullImageName3x;
    
    fullImageName3x = [imageName stringByAppendingString:@"@3x"];
    fullImageName2x = [imageName stringByAppendingString:@"@2x"];
    fullImageName = imageName;
    
    if (filepath) {
        
        fullImageName3x = [filepath stringByAppendingPathComponent:fullImageName3x];
        fullImageName2x = [filepath stringByAppendingPathComponent:fullImageName2x];
        fullImageName = [filepath stringByAppendingPathComponent:fullImageName];

    }
    
    fullImageName3x = [bundle pathForResource:fullImageName3x ofType:@"png"];
    fullImageName2x = [bundle pathForResource:fullImageName2x ofType:@"png"];
    fullImageName = [bundle pathForResource:fullImageName ofType:@"png"];
    
    if (fullImageName3x && [[NSFileManager defaultManager] fileExistsAtPath:fullImageName3x] && ([UIScreen mainScreen].scale == 3.0?YES:NO)) {
//        DLog(@"使用3x图片");
        return [UIImage imageWithContentsOfFile:fullImageName3x];
    }else if (fullImageName2x && [[NSFileManager defaultManager] fileExistsAtPath:fullImageName2x] && ([UIScreen mainScreen].scale >= 2.0?YES:NO)) {
//        DLog(@"使用2x图片");
        return [UIImage imageWithContentsOfFile:fullImageName2x];
    }else if (fullImageName && [[NSFileManager defaultManager] fileExistsAtPath:fullImageName]) {
        return [UIImage imageWithContentsOfFile:fullImageName];
    }
    
//    NSLog(@"图片:%@不存在",imageName);
    
    return nil;
    
}

+ (UIImage *)bt_imageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName
{
    return [UIImage bt_imageWithBundleName:bundleName filepath:nil imageName:imageName];
}

@end
