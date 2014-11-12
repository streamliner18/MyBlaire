//
//  TTXTransitionManager.m
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXTransitionManager.h"
#import <objc/runtime.h>
#import <dlfcn.h>

//设置一个默认的全局使用的type，默认是普通拖返模式
static TransitionGestureRecognizerType __TransitionGestureRecognizerType = TransitionGestureRecognizerTypePan;

#pragma mark - hook大法
//静态就交换静态，实例方法就交换实例方法
void __Transition_Swizzle(Class c, SEL origSEL, SEL newSEL)
{
    //获取实例方法
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method newMethod = nil;
	if (!origMethod) {
        //获取静态方法
		origMethod = class_getClassMethod(c, origSEL);
        newMethod = class_getClassMethod(c, newSEL);
    }else{
        newMethod = class_getInstanceMethod(c, newSEL);
    }
    
    if (!origMethod||!newMethod) {
        return;
    }
    
    //自身已经有了就添加不成功，直接交换即可
    if(class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        //添加成功一般情况是因为，origSEL本身是在c的父类里。这里添加成功了一个继承方法。
        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else{
        method_exchangeImplementations(origMethod, newMethod);
	}
}

@interface NSString (__TTXTransitionManager_Encrypt)

- (NSString *)__mlEncryptString;
- (NSString *)__mlDecryptString;

@end

@implementation NSString (__TTXTransitionManager_Encrypt)

- (NSString *)__mlRot13
{
    const char *source = [self cStringUsingEncoding:NSASCIIStringEncoding];
    char *dest = (char *)malloc((self.length + 1) * sizeof(char));
    if (!dest) {
        return nil;
    }
    
    NSUInteger i = 0;
    for ( ; i < self.length; i++) {
        char c = source[i];
        if (c >= 'A' && c <= 'Z') {
            c = (c - 'A' + 13) % 26 + 'A';
        }
        else if (c >= 'a' && c <= 'z') {
            c = (c - 'a' + 13) % 26 + 'a';
        }
        dest[i] = c;
    }
    dest[i] = '\0';
    
    NSString *result = [[NSString alloc] initWithCString:dest encoding:NSASCIIStringEncoding];
    free(dest);
    
    return result;
}

- (NSString *)__mlEncryptString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64 = [data base64EncodedStringWithOptions:0];
    return [base64 __mlRot13];
}

- (NSString *)__mlDecryptString
{
    NSString *rot13 = [self __mlRot13];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:rot13 options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end

#pragma mark - UIView category implementation
NSString * const kTransition_UIView_DisableTransition = @"__Transition_UIView_DisableTransition";
@implementation UIView(__TTXTransitionManager)

- (BOOL)disableTransition
{
	return [objc_getAssociatedObject(self, &kTransition_UIView_DisableTransition) boolValue];
}

- (void)setDisableTransition:(BOOL)disableTransition
{
    [self willChangeValueForKey:kTransition_UIView_DisableTransition];
	objc_setAssociatedObject(self, &kTransition_UIView_DisableTransition, @(disableTransition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kTransition_UIView_DisableTransition];
}

@end

#pragma mark - UIGestureRecognizer category interface
@interface UIGestureRecognizer(__Transition)

@property (nonatomic, assign) UINavigationController *__Transition_NavController;

@end

#pragma mark - UIGestureRecognizer category implementation
NSString * const kTransition_NavController_OfPan = @"__Transition_NavController_OfPan";

@implementation UIGestureRecognizer(__Transition)

- (void)set__Transition_NavController:(UINavigationController *)__Transition_NavController
{
    [self willChangeValueForKey:kTransition_NavController_OfPan];
	objc_setAssociatedObject(self, &kTransition_NavController_OfPan, __Transition_NavController, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:kTransition_NavController_OfPan];
}

- (UIViewController *)__Transition_NavController
{
	return objc_getAssociatedObject(self, &kTransition_NavController_OfPan);
}

@end

#pragma mark - UIPercentDrivenInteractiveTransition category
@interface UIPercentDrivenInteractiveTransition(__Transition)

@end

@implementation UIPercentDrivenInteractiveTransition(__Transition)

- (void)handleNavigationTransition:(UIPanGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        //做个样子,也用来防止如果这个api系统改了名字，我们这边还是可用的。
        [recognizer.__Transition_NavController popViewControllerAnimated:YES];
    }
}

@end

#pragma mark - UINavigationController category interface
@interface UINavigationController(__TTXTransitionManager)<UIGestureRecognizerDelegate>

/**
 *  每个导航器都添加一个拖动手势
 */
@property (nonatomic, strong) UIPanGestureRecognizer *__Transition_panGestureRecognizer;

- (void)__Transition_Hook_ViewDidLoad;

@end

#pragma mark - UINavigationController category implementation
NSString * const k__Transition_GestureRecognizer = @"__Transition_GestureRecognizer";

@implementation UINavigationController(__TTXTransitionManager)

#pragma mark getter and setter
- (void)set__Transition_panGestureRecognizer:(UIPanGestureRecognizer *)__Transition_panGestureRecognizer
{
    [self willChangeValueForKey:k__Transition_GestureRecognizer];
	objc_setAssociatedObject(self, &k__Transition_GestureRecognizer, __Transition_panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:k__Transition_GestureRecognizer];
}

- (UIPanGestureRecognizer *)__Transition_panGestureRecognizer
{
	return objc_getAssociatedObject(self, &k__Transition_GestureRecognizer);
}

#pragma mark hook
- (void)__Transition_Hook_ViewDidLoad
{
    [self __Transition_Hook_ViewDidLoad];
    
    //初始化拖返手势
    if (!self.__Transition_panGestureRecognizer&&[self.interactivePopGestureRecognizer.delegate isKindOfClass:[UIPercentDrivenInteractiveTransition class]]) {
        UIPanGestureRecognizer *gestureRecognizer = nil;

#define kHandleNavigationTransitionKey [@"nTShMTkyGzS2nJquqTyioyElLJ5mnKEco246" __mlDecryptString]
        if (__TransitionGestureRecognizerType == TransitionGestureRecognizerTypeScreenEdgePan) {
            gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:NSSelectorFromString(kHandleNavigationTransitionKey)];
            ((UIScreenEdgePanGestureRecognizer*)gestureRecognizer).edges = UIRectEdgeLeft;
        }else{
            gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:NSSelectorFromString(kHandleNavigationTransitionKey)];
        }
        
        gestureRecognizer.delegate = self;
        gestureRecognizer.__Transition_NavController = self;
        
        self.__Transition_panGestureRecognizer = gestureRecognizer;
        
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [self.view addGestureRecognizer:self.__Transition_panGestureRecognizer];
}

#pragma mark GestureRecognizer delegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)recognizer
{
    UINavigationController *navVC = self;
    if ([navVC.transitionCoordinator isAnimated]||
        navVC.viewControllers.count < 2) {
        return NO;
    }
    
    UIView* view = recognizer.view;
    CGPoint loc = [recognizer locationInView:view];
    UIView* subview = [view hitTest:loc withEvent:nil];
    if (subview.disableTransition){ //这个view忽略了拖返
        return NO;
    }
    
    //普通拖曳模式，如果开始方向不对即不启用
    if (__TransitionGestureRecognizerType==TransitionGestureRecognizerTypePan){
        CGPoint velocity = [recognizer velocityInView:navVC.view];
        if(velocity.x<=0) {
            //NSLog(@"不是右滑的");
            return NO;
        }
        
        CGPoint translation = [recognizer translationInView:navVC.view];
        translation.x = translation.x==0?0.00001f:translation.x;
        CGFloat ratio = (fabs(translation.y)/fabs(translation.x));
        //因为上滑的操作相对会比较频繁，所以角度限制少点
        if ((translation.y>0&&ratio>0.618f)||(translation.y<0&&ratio>0.2f)) {
            //NSLog(@"右滑角度不在范围内");
            return NO;
        }
    }
    
    return YES;
}
@end

@implementation UINavigationController(DisableTTXTransitionManager)

#pragma mark - outcall
- (void)enabledTransition:(BOOL)enabled
{
    self.__Transition_panGestureRecognizer.enabled = enabled;
}

@end

@implementation TTXTransitionManager

+ (void)validatePanPackWithTransitionGestureRecognizerType:(TransitionGestureRecognizerType)type
{
    //IOS7以下不可用
    if ([[[UIDevice currentDevice] systemVersion]floatValue]<7.0) {
        return;
    }
    
    //启用hook，自动对每个导航器开启拖返功能，整个程序的生命周期只允许执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //设置记录type,并且执行hook
        __TransitionGestureRecognizerType = type;
        
        __Transition_Swizzle([UINavigationController class],@selector(viewDidLoad),@selector(__Transition_Hook_ViewDidLoad));
    });
}

@end


#pragma mark - UIScrollView category ，可让scrollView在一个良好的关系下并存
@interface UIScrollView(__TTXTransistionManager)

@end

@implementation UIScrollView(__TTXTransistionManager)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isEqual:self.panGestureRecognizer]) {
        //如果此scrollView有横向滚动的可能当然就需要忽略了。
        if (CGAffineTransformEqualToTransform(CGAffineTransformMakeRotation(-M_PI*0.5),self.transform)||CGAffineTransformEqualToTransform(CGAffineTransformMakeRotation(M_PI*0.5),self.transform)) {
//            if (self.contentSize.height>self.frame.size.width) {
            //暂时对于这一种比较喜欢直接就不支持拖返吧，感觉体验好点。
                return NO;
//            }
        }else{
            if (self.contentSize.width>self.frame.size.width) {
                return NO;
            }
        }
        if (otherGestureRecognizer.__Transition_NavController) {
            //说明这玩意是我们的手势
            return YES;
        }
    }
    return NO;
}

@end


