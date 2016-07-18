//
//  Color_Marco.h
//  DouBanProject
//
//  Created by lanou3g on 16/5/6.
//  Copyright © 2016年 ccl. All rights reserved.
//

#ifndef Color_Marco_h
#define Color_Marco_h


//设置颜色
#define WH_COLOR(r,g,b,a) [UIColor colorWithRed:((r)/255.0) green:((g)/255.0) blue:((b)/255.0) alpha:a]
//随机颜色
#define WH_RANDOM_COLOR WH_COLOR(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255),1.0)


//主题颜色
#define THEM_COLOR WH_COLOR(30,170,190,1.0)

#endif /* Color_Marco_h */
