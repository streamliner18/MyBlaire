//
//  MBHomePageDataManager.m
//  MB
//
//  Created by Tongtong Xu on 14/12/1.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBHomePageDataManager.h"
#import "MBApi.h"


@implementation MBHomePageDataManager

+ (void)shareData:(MBHomePageDataManagerResult)result
{
    __block NSArray *discountArray;
    __block NSArray *popularArray;
    __block NSArray *starSameArray;
    [MBApi getNewDiscountGoodsWithCompletionHandle:^(MBApiError *error, id onearray) {
        if (error.code == MBApiCodeSuccess) {
            discountArray = onearray;
            [MBApi getHotGoodsWithCompletionHandle:^(MBApiError *error, id towarray) {
                if (error.code == MBApiCodeSuccess) {
                    popularArray = towarray;
                    [MBApi getStreetShootingGoodsWithCompletionHandle:^(MBApiError *error, id threearray) {
                        if (error.code == MBApiCodeSuccess) {
                            starSameArray = threearray;
                            if (result) {
                                result(error,discountArray,popularArray,starSameArray);
                            }
                        }else{
                            result(error,discountArray,popularArray,nil);
                        }
                    }];
                }else{
                    result(error,discountArray,nil,nil);
                }
            }];
        }else if (error.code == MBApiCodeUnLogin) {
            result (error,nil,nil,nil);
        }else{
            result (error,nil,nil,nil);
        }
    }];
}

@end
