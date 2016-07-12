//
//  CircleAnimation.h
//  test
//
//  Created by lanou on 16/7/9.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CircleAnimation : NSObject

/*
    使用方法：
 CircleAnimation *circle = [[CircleAnimation alloc]initWithBackgroundImage:@"1.jpg" addAtView:self.view];
 [circle addProgressBar];
 */

- (instancetype)initWithFrame:(CGRect)frame backgroundImage:(NSString *)image addAtView:(UIView *)view;

// 设置进度条
- (void)addProgressBar;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

/*
 CAShapeLayer 属性
 @property(nullable) CGPathRef path;
 
 填充颜色
 @property(nullable) CGColorRef fillColor;
 
 // 画笔颜色
 @property(nullable) CGColorRef strokeColor;
 // 画笔起始点
 @property CGFloat strokeStart;
 // 画笔终结点
 @property CGFloat strokeEnd;
 // 画笔线的宽度
 @property CGFloat lineWidth;
 
 // 其他属性
 */


@end
