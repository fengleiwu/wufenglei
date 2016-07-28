//
//  MusicActivityView.m
//  Project-A-Moment
//
//  Created by lanou on 16/7/5.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "MusicActivityView.h"

@implementation MusicActivityView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.numberOfRect = 6;
        self.rectBackgroundColor = PKCOLOR(56, 214, 85);
        self.space = 1;
        self.defaultSize = self.frame.size;
        
    }
    return self;
    
}


-(void)startAnimation{
    
    [self addRect];
    
    
    
}

-(void)stopAnimation{
    
    
    
    [self removeRect];
}


-(void)addRect{
    
    
    [self removeRect];
    
    self.hidden = NO;
    for (int i=0; i<self.numberOfRect; i++) {
        
        CGFloat x = (CGFloat)(i) * (5 + self.space);
        
        UIView *rView = [[UIView alloc]initWithFrame:CGRectMake(x, 0, 5, self.defaultSize.height)];
        rView.backgroundColor = self.rectBackgroundColor;
        [rView.layer addAnimation:[self addAnimateWithDelay:(double)i*0.2 ] forKey:@"TBRotate"];
        
        
        [self addSubview:rView];
        
    
    
    }

}
-(CAAnimation *)addAnimateWithDelay:(double)delay


{
 
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = true;
    animation.autoreverses = false;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:M_PI ];
    animation.duration = self.numberOfRect*0.2;
    animation.beginTime = CACurrentMediaTime()+delay;
    
    return animation;
    
}


-(void)removeRect{
    
    if (self.subviews.count>0) {
        [self removeFromSuperview];
        
    }
    self.hidden=YES;
    
    
}



@end
