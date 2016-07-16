//
//  CategoryCarouselModel.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryCarouselModel : NSObject

@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *shortTitle;

+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic;

@end
