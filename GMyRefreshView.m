//
//  GMyRefreshView.m
//  refreshTest
//
//  Created by golven on 15/7/31.
//  Copyright (c) 2015年 magicEngineer. All rights reserved.
//

#import "GMyRefreshView.h"

@interface GMyRefreshView()

@property (weak, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) GRefreshState currentState;
@property (assign, nonatomic) BOOL isRefresh;
@end

@implementation GMyRefreshView
{
    UIImageView *arrowImageView;
    UIActivityIndicatorView *indicator;
    UILabel *descLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self widgetInit];
    }
    return self;
}

//界面初始化...
- (void)widgetInit {
    _currentState = GRefreshStateDefault;
    
    UIImage *arrow = [UIImage imageNamed:@"arrow-white"];
    CGFloat arrowWidth = arrow.size.width;
    CGFloat arrowHeight = arrow.size.height;
    
    //箭头
    arrowImageView = [[UIImageView alloc] init];
    arrowImageView.frame = CGRectMake(0, 0, arrowWidth, arrowHeight);
    arrowImageView.center = CGPointMake(50, self.bounds.size.height/2);
    arrowImageView.image = [UIImage imageNamed:@"arrow-white"];
    [self addSubview:arrowImageView];
    
    //文字提示
    descLabel = [[UILabel alloc] initWithFrame:self.bounds];
    descLabel.backgroundColor = [UIColor clearColor];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.text = GRefreshDefaultTitle;
    descLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:descLabel];
    
    //菊花
    indicator = [[UIActivityIndicatorView alloc] init];
    indicator.frame = CGRectMake(0, 0, 25, 25);
    indicator.center = arrowImageView.center;
    [self addSubview:indicator];
}

- (void)stopRefresh {
    if (_isRefresh == NO) {
        return;
    }
    [self scrollViewContentInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [indicator stopAnimating];
    descLabel.text = GRefreshDefaultTitle;
    [self arrowImageViewAnimationWithProgress:0 hidden:NO];
    _isRefresh = NO;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    
    if (newSuperview) {
        self.scrollView = (UIScrollView *)newSuperview;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint point = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        NSInteger offset = point.y;
        NSLog(@"%f",point.y);
        if (_isRefresh) {
            return;
        }
        if (self.scrollView.isDragging && offset > -self.bounds.size.height) {
            self.currentState = GRefreshStateDefault;
        } else if (self.scrollView.isDragging && offset <= -self.bounds.size.height) {
            self.currentState = GRefreshStateSlide;
        }
        
        if (!self.scrollView.isDragging && offset > -self.bounds.size.height) {
            return;
        } else if (!self.scrollView.isDragging && offset <= -self.bounds.size.height){
            self.currentState = GRefreshStateLodding;
        }
    }
}

- (void)setCurrentState:(GRefreshState)currentState{
    _currentState = currentState;
    
    switch (currentState) {
        case GRefreshStateDefault:
            _isRefresh = NO;
            [indicator stopAnimating];
            descLabel.text = GRefreshDefaultTitle;
            [self arrowImageViewAnimationWithProgress:0 hidden:NO];
            break;
        case GRefreshStateLodding:
            _isRefresh = YES;
            [indicator startAnimating];
            descLabel.text = GRefreshLoaddingTitle;
            [self arrowImageViewAnimationWithProgress:M_PI hidden:YES];
            [self scrollViewContentInsets:UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0)];
            break;
        case GRefreshStateSlide:
            _isRefresh = NO;
            [indicator stopAnimating];
            descLabel.text = GRefreshSlideTitle;
            [self arrowImageViewAnimationWithProgress:M_PI hidden:NO];
            break;
            
        default:
            break;
    }
}

- (void)scrollViewContentInsets:(UIEdgeInsets)contentInset {
    [UIView animateWithDuration:.35 animations:^{
        [self.scrollView setContentInset:contentInset];
    }];
}

- (void)arrowImageViewAnimationWithProgress:(CGFloat)progress hidden:(BOOL)hidden{
    [UIView animateWithDuration:.25 animations:^{
        arrowImageView.layer.transform = CATransform3DMakeRotation(progress, 0, 0, 1);
        arrowImageView.hidden = hidden;
    }];
}
@end


















