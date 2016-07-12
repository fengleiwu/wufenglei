//
//  TypeModel.m
//  Product-BB
//
//  Created by 林建 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TypeModel.h"

@implementation TypeModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

+(NSMutableArray *)ModelConfigureWithJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *Arr = [NSMutableArray array];
    NSDictionary *data = jsonDic[@"data"];
    NSArray *arr = data[@"categories"];
    for (NSDictionary *dic in arr) {
        TypeModel *model = [[TypeModel alloc]init];
        model.idd = dic[@"id"];
        [model setValuesForKeysWithDictionary:dic];
        [Arr addObject:model];
    }
    return Arr;
}

@end
