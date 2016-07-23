//
//  TopWindow.m
//  Product-BB
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopWindow.h"

@implementation TopWindow

static UIWindow *topWindow_;

/**
 * 显示顶部窗口
 */
+ (void)show
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        topWindow_ = [[UIWindow alloc] init];
        topWindow_.windowLevel = UIWindowLevelAlert;
        topWindow_.frame = [UIApplication sharedApplication].statusBarFrame;
        topWindow_.backgroundColor = [UIColor clearColor];
        topWindow_.hidden = NO;
        [topWindow_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topWindowClick)]];
    });
}

/**
 * 监听顶部窗口点击
 */
+ (void)topWindowClick
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self searchAllScrollViewsInView:keyWindow];
}

/**
 * 找到参数view中所有的UIScrollView
 */
+ (void)searchAllScrollViewsInView:(UIView *)view
{
    // 递归遍历所有的子控件
    for (UIView *subview in view.subviews) {
        [self searchAllScrollViewsInView:subview];
    }

    // 判断子控件类型(如果不是UIScrollView，直接返回)
    if (![view isKindOfClass:[UIScrollView class]]) return;
    
    // 找到了UIScrollView
    UIScrollView *scrollView = (UIScrollView *)view;
    
    // 判断UIScrollView是否和window重叠（如果UIScrollView跟window没有重叠，直接返回）
    if (!( (topWindow_.frame.origin.x+topWindow_.frame.size.width >=scrollView.frame.origin.x) && (topWindow_.frame.origin.x+topWindow_.frame.size.width <= scrollView.frame.origin.x+scrollView.frame.size.width)))
        return;
    
    // 让UIScrollView滚动到最前面
     [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0) animated:YES];
}

@end
