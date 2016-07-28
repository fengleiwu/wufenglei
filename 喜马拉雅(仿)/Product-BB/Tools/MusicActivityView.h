//
//  MusicActivityView.h
//  Project-A-Moment
//
//  Created by lanou on 16/7/5.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicActivityView : UIView




@property (nonatomic,assign)NSInteger numberOfRect;
@property (nonatomic,strong)UIColor *rectBackgroundColor;
@property (nonatomic,assign)CGSize defaultSize;
@property (nonatomic,assign)CGFloat space;


-(void)startAnimation;
-(void)stopAnimation;
@end
