//   UIViewController+Tracker.m
//   GCTrackerKit
//   
//   Created  by Geeks_Chen on 2020/9/3
//   Copyright © 2020 mycompany. All rights reserved.

#import "UIViewController+Tracker.h"
#import <objc/runtime.h>
#import "GCTrackerTool.h"

@implementation UIViewController (Tracker)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalAppearSelector = @selector(viewWillAppear:);
        SEL swizzingAppearSelector = @selector(gc_viewWillAppear:);
        [GCTrackerTool swizzlingInClass:[self class] originalSelector:originalAppearSelector swizzledSelector:swizzingAppearSelector];
        
        SEL originalDisappearSelector = @selector(viewWillDisappear:);
        SEL swizzingDisappearSelector = @selector(gc_viewWillDisappear:);
        [GCTrackerTool swizzlingInClass:[self class] originalSelector:originalDisappearSelector swizzledSelector:swizzingDisappearSelector];
    });
}

-(void)gc_viewWillAppear:(BOOL)animated
{
    [self gc_viewWillAppear:animated];
    NSLog(@"【PV】%@-%@", [self class],@"viewWillAppear");
}


-(void)gc_viewWillDisappear:(BOOL)animated
{
    [self gc_viewWillDisappear:animated];
    NSLog(@"【PV】%@-%@", [self class],@"viewWillDisappear");
}

@end
