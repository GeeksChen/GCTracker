//   GCTrackerTool.h
//   GCTrackerKit
//   
//   Created  by Geeks_Chen on 2020/9/3
//   Copyright © 2020 mycompany. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCTrackerTool : NSObject

+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

- (void)trackAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;

- (void)pageWillAppearWithVc:(NSString *)vc;

- (void)pageDisAppearWithVc:(NSString *)vc;

@end

NS_ASSUME_NONNULL_END
