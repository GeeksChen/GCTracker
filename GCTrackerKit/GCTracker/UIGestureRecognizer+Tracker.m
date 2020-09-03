//   UIGestureRecognizer+Tracker.m
//   GCTrackerKit
//   
//   Created  by Geeks_Chen on 2020/9/3
//   Copyright © 2020 mycompany. All rights reserved.

#import "UIGestureRecognizer+Tracker.h"
#import <objc/runtime.h>
#import "UIGestureRecognizer+MethodName.h"
#import "GCTrackerTool.h"

@implementation UIGestureRecognizer (Tracker)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [GCTrackerTool swizzlingInClass:[self class] originalSelector:@selector(initWithTarget:action:) swizzledSelector:@selector(gc_initWithTarget:action:)];
    });
}

- (instancetype)gc_initWithTarget:(nullable id)target action:(nullable SEL)action
{
    UIGestureRecognizer *selfGestureRecognizer = [self gc_initWithTarget:target action:action];
    
    if (!target && !action) {
        return selfGestureRecognizer;
    }
    
    if ([target isKindOfClass:[UIScrollView class]]) {
        return selfGestureRecognizer;
    }
    
    Class class = [target class];
    
    
    SEL sel = action;
    
    NSString * sel_name = [NSString stringWithFormat:@"%s/%@", class_getName([target class]),NSStringFromSelector(action)];
    SEL sel_ =  NSSelectorFromString(sel_name);
    
    BOOL isAddMethod = class_addMethod(class,
                                       sel_,
                                       method_getImplementation(class_getInstanceMethod([self class], @selector(responseUser_gesture:))),
                                       nil);
    
    self.methodName = NSStringFromSelector(action);
    if (isAddMethod) {
        Method selMethod = class_getInstanceMethod(class, sel);
        Method sel_Method = class_getInstanceMethod(class, sel_);
        method_exchangeImplementations(selMethod, sel_Method);
    }
    
    return selfGestureRecognizer;
}

-(void)responseUser_gesture:(UIGestureRecognizer *)gesture
{
    
    NSString * identifier = [NSString stringWithFormat:@"%s/%@", class_getName([self class]),gesture.methodName];
    
    SEL sel = NSSelectorFromString(identifier);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL,id) = (void *)imp;
        func(self, sel,gesture);
    }
    
    NSLog(@"【Gesture】%@-%@", NSStringFromClass([self class]), gesture.methodName);
}

@end
