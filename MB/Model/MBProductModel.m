//
//  MBProductModel.m
//  MB
//
//  Created by Tongtong Xu on 14/11/14.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBProductModel.h"

@implementation MBProductModel

#define kGOODSIMAGEHEADER

+ (instancetype)shareProduct:(NSDictionary *)dic
{
    MBProductModel *model = [[MBProductModel alloc] init];
    model.goodId = [dic stringForKey:@"goodId"];
    model.goodName = [dic stringForKey:@"goodName"];
    model.currentPrice = [dic stringForKey:@"currentPrice"];
    model.collectCount = [dic intForKey:@"collectCount"];
    model.isCollect = [[dic stringForKey:@"isCollect"] boolValue];
    model.imageWidth = 90;
    model.imageHeight = 120;
    model.smallPicture = [MBApi serverImageURLWithImageName:[dic stringForKey:@"imageThumbnail"]];
    model.imageSlideshow = [MBApi serverImageURLWithImageName:[dic stringForKey:@"imageSlideshow"]];
    model.imageHighlight = [MBApi serverImageURLWithImageName:[dic stringForKey:@"imageHighlight"]];
    model.imageTrending = [MBApi serverImageURLWithImageName:[dic stringForKey:@"imageTrending"]];
    return model;
}

- (void)updateWithDic:(NSDictionary *)dic
{
    if (dic) {
        self.detailed = [dic stringForKey:@"detailed"];
        self.materialQuality = [dic stringForKey:@"materialQuality"];
        self.color = [dic stringForKey:@"color"];
        self.goodDesc = [dic stringForKey:@"goodDesc"];
        self.production = [dic stringForKey:@"production"];
        self.bigPctureUrl = [dic stringForKey:@"bigPctureUrl"];
        self.bigPctureUrl2 = [dic stringForKey:@"bigPctureUrl2"];
        self.bigPctureUrl3 = [dic stringForKey:@"bigPctureUrl3"];
        self.buyURL = [dic stringForKey:@"buyUrl"];
        NSMutableArray *array = @[].mutableCopy;
        NSArray *images = [dic arrayForKey:@"imageBig"];
        for (NSDictionary *subDic in images) {
            if ([subDic isKindOfClass:[NSDictionary class]]) {
                NSString *imageName = [subDic stringForKey:@"imageUrl"];
                if (imageName.length > 0) {
                    [array addObject:[MBApi serverImageURLWithImageName:imageName]];
                }
            }
        }
        self.bigPictures = [NSArray arrayWithArray:array];
    }
}

+ (NSArray *)productsWithArray:(NSArray *)array
{
    NSMutableArray *mulArray = @[].mutableCopy;
    for (NSDictionary *dic in array) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            MBProductModel *model = [MBProductModel shareProduct:dic];
            [mulArray addObject:model];
        }
    }
    return [NSArray arrayWithArray:mulArray];
}

- (NSString *)collecteViewNeedShowImageURL
{
    if (self.smallPicture) {
        return self.smallPicture;
    }
    if (self.imageHighlight) {
        return self.imageHighlight;
    }
    if (self.imageSlideshow) {
        return self.imageSlideshow;
    }
    if (self.imageTrending) {
        return self.imageTrending;
    }
    return nil;
}

@end
