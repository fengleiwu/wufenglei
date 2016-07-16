//
//  AdjustHeight.h
//  UILesson12-UITableViewCell
//
//  Created by lanou on 16/5/12.
//  Copyright © 2016年 lanou. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface AdjustHeight : NSObject

//hidth
//用来计算字符串的高度
+(CGFloat)adjustHeightByString:(NSString *)text width:(CGFloat)width font:(CGFloat)font;




+(CGFloat)adjustHeightByString:(NSString *)text hidth:(CGFloat)hidth font:(CGFloat)font;






@end
