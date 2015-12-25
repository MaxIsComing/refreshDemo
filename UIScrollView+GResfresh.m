//
//  UIScrollView+GResfresh.m
//  refreshTest
//
//  Created by golven on 15/7/31.
//  Copyright (c) 2015年 magicEngineer. All rights reserved.
//

#import "UIScrollView+GResfresh.h"
#import <objc/runtime.h>

static void *keyString = (void *)@"GRefresh";

@implementation UIScrollView (GResfresh)

- (UIView *)header{
    return objc_getAssociatedObject(self, keyString);
}

- (void)setHeader:(UIView *)header {
    if (self.header) {
        [self.header removeFromSuperview];
    }
    [self addSubview:header];
    objc_setAssociatedObject(self, keyString, header, OBJC_ASSOCIATION_RETAIN);
}

@end
