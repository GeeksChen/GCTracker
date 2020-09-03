//   GCTrackerTool.m
//   GCTrackerKit
//   
//   Created  by Geeks_Chen on 2020/9/3
//   Copyright © 2020 mycompany. All rights reserved.

#import "GCTrackerTool.h"
#import <objc/runtime.h>

@implementation GCTrackerTool

+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Class class = cls;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)trackAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    NSString *eventID = nil;
    //只统计触摸结束时
    if ([[[event allTouches] anyObject] phase] == UITouchPhaseEnded) {
        NSString *actionString = NSStringFromSelector(action);
        NSString *targetName = NSStringFromClass([target class]);
    
        NSLog(@"【Action】%@-%@",targetName,actionString);
    }
}

- (void)pageWillAppearWithVc:(NSString *)vc {
    
    NSLog(@"【PV】pageWillAppear-%@",vc);
}

- (void)pageDisAppearWithVc:(NSString *)vc {
    
    NSLog(@"【PV】pageDisAppear-%@",vc);
}

//- (NSDictionary *)getConfigDict {
//    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SDTrackEvents" ofType:@"plist"];
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
//    return dic;
//}
@end
