//
//  recommendMoreModel.m
//  Product-BB
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "recommendMoreModel.h"

@implementation recommendMoreModel



-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}



+(NSMutableArray *)recommendMore:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *list = dic[@"list"];
    for (NSDictionary *dic1 in list) {
        recommendMoreModel *model = [[recommendMoreModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model];
    }
    return arr;
}

@end
