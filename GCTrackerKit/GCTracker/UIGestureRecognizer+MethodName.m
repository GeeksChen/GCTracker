//   UIGestureRecognizer+MethodName.m
//   GCTrackerKit
//   
//   Created  by Geeks_Chen on 2020/9/3
//   Copyright © 2020 mycompany. All rights reserved.

#import "UIGestureRecognizer+MethodName.h"
#import <objc/runtime.h>

@implementation UIGestureRecognizer (MethodName)

-(void)setMethodName:(NSString *)methodName
{
    objc_setAssociatedObject(self, @"methodName", methodName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)methodName
{
    return objc_getAssociatedObject(self, @"methodName");
}

@end
