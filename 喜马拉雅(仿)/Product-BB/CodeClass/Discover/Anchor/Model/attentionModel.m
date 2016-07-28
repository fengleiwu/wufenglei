//
//  attentionModel.m
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/17.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "attentionModel.h"

@implementation attentionModel



-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


+(attentionModel *)top:(NSDictionary *)dic
{
    attentionModel *model = [[attentionModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}


+(NSMutableArray *)middle:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *list = dic[@"list"];
    for (NSDictionary *dic1 in list) {
        attentionModel *attent = [[attentionModel alloc]init];
        [attent setValuesForKeysWithDictionary:dic1];
        [arr addObject:attent];
        
    }
    return arr;
}


+(NSMutableArray *)bottom:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *list = dic[@"list"];
    for (NSDictionary *dic1 in list) {
        attentionModel *model = [[attentionModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model];
    }
    return arr;
    
}


+(NSMutableArray *)price:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *list = dic[@"list"];
    for (NSDictionary *dic1 in list) {
        attentionModel *model = [[attentionModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model];
    }
    return arr;
}


@end
