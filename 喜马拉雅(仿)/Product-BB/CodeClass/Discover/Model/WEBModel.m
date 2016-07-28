//
//  WEBModel.m
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/12.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "WEBModel.h"

@implementation WEBModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


+(NSMutableArray *)webWith:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *data = dic[@"data"];
    for (NSDictionary *dic2 in data) {
        WEBModel *model = [[WEBModel alloc]init];
        [model setValuesForKeysWithDictionary:dic2];
        [arr addObject:model];
    }
    return arr;
}



@end
