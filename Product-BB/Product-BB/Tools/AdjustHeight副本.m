//
//  AdjustHeight.m
//  DouBan
//
//  Created by 林建 on 16/5/25.
//  Copyright © 2016年 林建. All rights reserved.
//

#import "AdjustHeight.h"

@implementation AdjustHeight
+(CGFloat)adjustHeightBystring:(NSString *)text width:(CGFloat)width font:(CGFloat)font{
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGFloat h =[text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
    return h;
}

+(CGFloat)adjustWidthBystring:(NSString *)text width:(CGFloat)width font:(CGFloat)font{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGFloat w =[text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
    return h;
}
@end
