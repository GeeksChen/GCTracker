//   UIControl+Tracker.m
//   GCTrackerKit
//   
//   Created  by Geeks_Chen on 2020/9/3
//   Copyright © 2020 mycompany. All rights reserved.

#import "UIControl+Tracker.h"
#import <objc/runtime.h>
#import "GCTrackerTool.h"

@implementation UIControl (Tracker)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzingSelector = @selector(gc_sendAction:to:forEvent:);
        [GCTrackerTool swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzingSelector];
    });
}

-(void)gc_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [self gc_sendAction:action to:target forEvent:event];
    NSLog(@"【Action】%@-%@-%ld",[target class], NSStringFromSelector(action),(long)self.tag);
}
@end
