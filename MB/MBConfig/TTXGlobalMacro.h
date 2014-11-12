//
//  TTXMacro.h
//  MB
//
//  Created by Tongtong Xu on 14-11-10.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^TTXActionBlock)();

// 单例
#define SINGLETON_INTERFACE(CLASSNAME)              \
+ (CLASSNAME*)shared;

#define SINGLETON_IMPLEMENTATION(CLASSNAME)         \
\
static CLASSNAME* g_shared##CLASSNAME = nil;        \
\
+ (CLASSNAME*)shared                                \
{                                                   \
static dispatch_once_t oncePredicate;           \
dispatch_once(&oncePredicate, ^{                \
g_shared##CLASSNAME = [[self alloc] init];  \
});                                             \
return g_shared##CLASSNAME;                     \
}                                                   \
\
+ (id)allocWithZone:(NSZone*)zone                   \
{                                                   \
@synchronized(self) {                               \
if (g_shared##CLASSNAME == nil) {                   \
g_shared##CLASSNAME = [super allocWithZone:zone];   \
return g_shared##CLASSNAME;                         \
}                                                   \
}                                                   \
NSAssert(NO, @ "[" #CLASSNAME                       \
" alloc] explicitly called on singleton class.");   \
return nil;                                         \
}                                                   \
\
- (id)copyWithZone:(NSZone*)zone                    \
{                                                   \
return self;                                        \
}                                                   \



