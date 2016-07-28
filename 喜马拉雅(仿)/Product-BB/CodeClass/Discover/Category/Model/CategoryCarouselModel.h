//
//  CategoryCarouselModel.h
//  Product-B
//
//  Created by 吴峰磊 on 16/7/12.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryCarouselModel : NSObject

@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *shortTitle;

+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic;

@end
