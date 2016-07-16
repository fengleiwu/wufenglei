//
//  DetailPayModel.m
//  Product-BB
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DetailPayModel.h"

@implementation DetailPayModel



-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)list:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *data = dic[@"data"];
    NSDictionary *comments = data[@"comments"];
    NSArray *list = comments[@"list"];
    for (NSDictionary *dic1 in list) {
        DetailPayModel *model = [[DetailPayModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model];
        
        
    }
    return arr;
}
+(DetailPayModel *)detail:(NSDictionary *)dic
{
    NSDictionary *data = dic[@"data"];
    NSDictionary *detail = data[@"detail"];
    DetailPayModel *model = [[DetailPayModel alloc]init];
    [model setValuesForKeysWithDictionary:detail];
    return model;
}


+(DetailPayModel *)user:(NSDictionary *)dic
{
    NSDictionary *data = dic[@"data"];
    NSDictionary *user = data[@"user"];
    DetailPayModel *model = [[DetailPayModel alloc]init];
    [model setValuesForKeysWithDictionary:user];
    return model;
}

@end
