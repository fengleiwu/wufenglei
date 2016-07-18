//
//  hotRecommendsModel.m
//  Product-BB
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "hotRecommendsModel.h"

@implementation hotRecommendsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)hotRecommends:(NSDictionary *)dic
{
    
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *hotRecommends = dic[@"hotRecommends"];
    NSArray *list = hotRecommends[@"list"];
    for (NSDictionary *dic1 in list) {
        NSMutableArray *arr1 = [NSMutableArray array];
        NSArray *lis = dic1[@"list"];
        for (NSDictionary *dic2 in lis) {
            hotRecommendsModel *model = [[hotRecommendsModel alloc]init];
            model.categoryId = [NSString stringWithFormat:@"%ld",[dic1[@"categoryId"] integerValue]];
            [model setValuesForKeysWithDictionary:dic2];
            [arr1 addObject:model];
        }
        [arr addObject:arr1];
        
    }
    return arr;
    
    
}


+(NSMutableArray *)title:(NSDictionary *)dic1
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *hotRecommends = dic1[@"hotRecommends"];
    NSArray *list = hotRecommends[@"list"];
    for (NSDictionary *dic2 in list) {
        hotRecommendsModel *model = [[hotRecommendsModel alloc]init];
        [model setValuesForKeysWithDictionary:dic2];
        [arr addObject:model];
    }
    return arr;
}




@end
