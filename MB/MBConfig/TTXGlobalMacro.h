//
//  TTXMacro.h
//  MB
//
//  Created by Tongtong Xu on 14-11-10.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

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

// Check OS version
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define iOS5 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")
#define iOS6 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")
#define iOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define iOS8 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define iOS4Only (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"4.0") && SYSTEM_VERSION_LESS_THAN(@"5.0"))
#define iOS5Only (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0") && SYSTEM_VERSION_LESS_THAN(@"6.0"))
#define iOS6Only (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0") && SYSTEM_VERSION_LESS_THAN(@"7.0"))
#define iOS7Only (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0") && SYSTEM_VERSION_LESS_THAN(@"8.0"))
#define iOS8Only (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") && SYSTEM_VERSION_LESS_THAN(@"9.0"))

