//
//  ListenDetailModel.m
//  Product-BB
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ListenDetailModel.h"

@implementation ListenDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.myid = value;
    }
}



+(ListenDetailModel *)model:(NSDictionary *)dic
{
    ListenDetailModel *model1 = [[ListenDetailModel alloc]init];
    NSDictionary *info = dic[@"info"];
    [model1 setValuesForKeysWithDictionary:info];
    return model1;
}

+(NSMutableArray *)arr:(NSDictionary *)dic
{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSArray *list = dic[@"list"];
    for (NSDictionary *dic1 in list) {
        ListenDetailModel *model = [[ListenDetailModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr1 addObject:model];
    }
    return arr1;
}

@end
