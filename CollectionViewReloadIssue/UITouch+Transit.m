//
//  UITouch+Transit.m
//  TransitBeta
//
//  Created by Felix Lapalme on 2018-12-21.
//

#import "UITouch+Transit.h"
#import <objc/runtime.h>

@implementation UITouch (Transit)

- (void)setSp_overrideView:(UIView *)overrideView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(view) withMethod:@selector(sp_view) forClass:UITouch.class];
    });
    
    objc_setAssociatedObject(self, @selector(sp_overrideView), overrideView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)sp_view {
    UIView *overrideView = objc_getAssociatedObject(self, @selector(sp_overrideView));

    if (overrideView) {
        return overrideView;
    }
    else {
        return [self sp_view];
    }
}

- (UIView *)sp_overrideView {
    return objc_getAssociatedObject(self, @selector(sp_overrideView));
}

- (void)swizzleMethod:(SEL)selector withMethod:(SEL)otherSelector forClass:(Class) class {
    Method originalMethod = class_getInstanceMethod(class, selector);
    Method otherMethod = class_getInstanceMethod(class, otherSelector);

    if (class_addMethod(class, selector, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod))) {
        class_replaceMethod(class,
                            otherSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, otherMethod);
    }
}

@end
