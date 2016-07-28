//
//  CategoryBottomModel.m
//  Product-B
//
//  Created by 吴峰磊 on 16/7/12.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "CategoryBottomModel.h"

@implementation CategoryBottomModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic {
    NSMutableArray *array = [NSMutableArray array];
    NSArray *listArr = jsonDic[@"list"];
    for (NSDictionary *dic in listArr) {
        CategoryBottomModel *model = [[CategoryBottomModel alloc]init];
        model.myid = dic[@"id"];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}

@end
