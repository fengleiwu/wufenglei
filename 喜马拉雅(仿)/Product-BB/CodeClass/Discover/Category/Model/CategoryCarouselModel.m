//
//  CategoryCarouselModel.m
//  Product-B
//
//  Created by 吴峰磊 on 16/7/12.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "CategoryCarouselModel.h"

@implementation CategoryCarouselModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic {
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *focusImageDic = jsonDic[@"focusImages"];
    NSArray *listArr = focusImageDic[@"list"];
    for (NSDictionary *dic in listArr) {
        CategoryCarouselModel *model = [[CategoryCarouselModel alloc]init];
        model.pic = dic[@"pic"];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    
    return array;
}


@end
