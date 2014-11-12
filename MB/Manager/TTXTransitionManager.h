//
//  TTXTransitionManager.h
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TransitionGestureRecognizerTypePan, //拖动模式
	TransitionGestureRecognizerTypeScreenEdgePan, //边界拖动模式
} TransitionGestureRecognizerType;

@interface TTXTransitionManager : NSObject

+ (void)validatePanPackWithTransitionGestureRecognizerType:(TransitionGestureRecognizerType)type;

@end

@interface UIView(__TTXTransitionManager)

//使得此view不响应拖返
@property (nonatomic, assign) BOOL disableTransition;

@end

@interface UINavigationController(DisableTTXTransitionManager)

- (void)enabledTransition:(BOOL)enabled;

@end
