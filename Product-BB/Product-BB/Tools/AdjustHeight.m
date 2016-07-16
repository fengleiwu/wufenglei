//
//  AdjustHeight.m
//  UILesson12-UITableViewCell
//
//  Created by lanou on 16/5/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AdjustHeight.h"

@implementation AdjustHeight


+(CGFloat)adjustHeightByString:(NSString *)text width:(CGFloat)width font:(CGFloat)font
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
   CGFloat h = [text boundingRectWithSize:CGSizeMake(width, 10000) options: NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
    return h;
}

+(CGFloat)adjustHeightByString:(NSString *)text hidth:(CGFloat)hidth font:(CGFloat)font
{
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:font]};
    CGFloat h = [text boundingRectWithSize:CGSizeMake(1000, hidth) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.width;
    return h;
}

@end
