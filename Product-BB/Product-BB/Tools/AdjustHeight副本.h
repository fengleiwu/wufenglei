//
//  AdjustHeight.h
//  DouBan
//
//  Created by 林建 on 16/5/25.
//  Copyright © 2016年 林建. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
@interface AdjustHeight : NSObject
+(CGFloat)adjustHeightBystring:(NSString *)text width:(CGFloat)width font:(CGFloat)font;

+(CGFloat)adjustWidthBystring:(NSString *)text width:(CGFloat)width font:(CGFloat)font;
@end
