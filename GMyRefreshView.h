//
//  GMyRefreshView.h
//  refreshTest
//
//  Created by golven on 15/7/31.
//  Copyright (c) 2015年 magicEngineer. All rights reserved.
//

#import <UIKit/UIKit.h>

//在预编译阶段替换
#define GRefreshDefaultTitle @"下拉刷新..."
#define GRefreshSlideTitle @"松手立即刷新..."
#define GRefreshLoaddingTitle @"正在刷新..."

typedef enum {
    GRefreshStateDefault = 0,
    GRefreshStateSlide,
    GRefreshStateLodding
}GRefreshState;

@interface GMyRefreshView : UIView

- (void)stopRefresh;

@end
