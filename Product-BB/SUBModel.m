//
//  SUBModel.m
//  Product-BB
//
//  Created by 林建 on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "SUBModel.h"

@implementation SUBModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic{
    NSMutableArray *Arr = [NSMutableArray array];
    NSDictionary *data = jsonDic[@"data"];
    NSArray *arr = data[@"list"];
    for (NSDictionary *dic in arr) {
        SUBModel *model = [[SUBModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [Arr addObject:model];
    }
    return Arr;
}
@end
