//   UICollectionView+Tracker.m
//   GCTrackerKit
//   
//   Created  by Geeks_Chen on 2020/9/3
//   Copyright © 2020 mycompany. All rights reserved.

#import "UICollectionView+Tracker.h"
#import <objc/runtime.h>
#import "GCTrackerTool.h"

@implementation UICollectionView (Tracker)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalAppearSelector = @selector(setDelegate:);
        SEL swizzingAppearSelector = @selector(gc_setDelegate:);
        [GCTrackerTool swizzlingInClass:[self class] originalSelector:originalAppearSelector swizzledSelector:swizzingAppearSelector];
    });
}

- (void)gc_setDelegate:(id<UICollectionViewDelegate>)delegate
{
    [self gc_setDelegate:delegate];
    
    SEL sel = @selector(collectionView:didSelectItemAtIndexPath:);
        
    SEL sel_ = NSSelectorFromString([NSString stringWithFormat:@"%@/%@", NSStringFromClass([delegate class]), NSStringFromClass([self class])]);

    class_addMethod([delegate class],
                    sel_,
                    method_getImplementation(class_getInstanceMethod([self class], @selector(gc_collectionView:didSelectItemAtIndexPath:))),
                    nil);
    
    
    //判断是否有实现，没有的话添加一个实现
    if (![self isContainSel:sel inClass:[delegate class]]) {
        IMP imp = method_getImplementation(class_getInstanceMethod([delegate class], sel));
        class_addMethod([delegate class], sel, imp, nil);
    }

    // 将swizzle delegate method 和 origin delegate method 交换
    [GCTrackerTool swizzlingInClass:[delegate class] originalSelector:sel swizzledSelector:sel_];

}

//判断页面是否实现了某个sel
- (BOOL)isContainSel:(SEL)sel inClass:(Class)class {
    unsigned int count;
    
    Method *methodList = class_copyMethodList(class,&count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *tempMethodString = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
    
        if ([tempMethodString isEqualToString:NSStringFromSelector(sel)]) {
            return YES;
        }
    }
    return NO;
}

- (void)gc_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{

    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@/%@", NSStringFromClass([self class]),  NSStringFromClass([collectionView class])]);

    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL,id,id) = (void *)imp;
        func(self, sel,collectionView,indexPath);
    }
    NSLog(@"【collectionView】%@-%@-section:%ld-row:%ld",[self class],[collectionView class], indexPath.section, indexPath.row);

}


@end
