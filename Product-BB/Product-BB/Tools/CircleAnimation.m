//
//  CircleAnimation.m
//  test
//
//  Created by lanou on 16/7/9.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CircleAnimation.h"
#import "UIImageView+WebCache.h"

@interface CircleAnimation ()

@property (nonatomic, assign) CGRect frame;

// 背景图片
@property (nonatomic, strong) UIImageView *imageV;
// 下面的 view。
@property (nonatomic, strong) UIView *bassView;

@end

@implementation CircleAnimation

- (instancetype)initWithFrame:(CGRect)frame backgroundImage:(NSString *)img addAtView:(UIView *)view {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.bassView = view;
        self.imageV = [[UIImageView alloc]initWithFrame:self.shapeLayer.frame];
        if ([img containsString:@"http://"]) {
            [self.imageV sd_setImageWithURL:[NSURL URLWithString:img]];
        } else {
            self.imageV.image = [UIImage imageNamed:img];
        }

    }
    return self;
}


 // 进度条 progress bar;
- (void)addProgressBar {
   
    //创建出CAShapeLayer
    self.shapeLayer = [CAShapeLayer layer];
//    shapeLayer.frame = CGRectMake(0, 0, self.bassView.frame.size.width, self.bassView.frame.size.height);//设置shapeLayer的尺寸和位置
//    shapeLayer.position = self.bassView.center;
    self.shapeLayer.frame = self.frame;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 1;
    self.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:self.shapeLayer.frame];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    
    //设置stroke起始点
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0.1;
    
    //添加并显示
    [self.bassView.layer addSublayer:self.shapeLayer];
    
    // 添加图片
    UIImageView * imagev = [[UIImageView alloc]initWithFrame:self.shapeLayer.frame];
    imagev.center = self.shapeLayer.position;
    imagev.layer.masksToBounds = YES;
    imagev.layer.cornerRadius = self.shapeLayer.frame.size.height / 2 + self.shapeLayer.lineWidth + 1;
    imagev.image = self.imageV.image;
    [self.shapeLayer addSublayer:imagev.layer];
}



@end
