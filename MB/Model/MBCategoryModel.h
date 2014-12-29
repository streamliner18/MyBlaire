//
//  MBCategoryModel.h
//  MB
//
//  Created by Tongtong Xu on 14/11/27.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBCategoryModel : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *imageName;
+ (NSArray *)defaultCategoryModelArray;
@end
