//
//  AnchorModel.m
//  Product-BB
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AnchorModel.h"

@implementation AnchorModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.myId = value;
    }
}

+(NSMutableArray *)famousMyID:(NSDictionary *)dic
{
    
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *famous = dic[@"famous"];
    for (NSDictionary *dic1 in famous) {
        AnchorModel *model = [[AnchorModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model.myId];
    }
    return arr;
}

+(NSMutableArray *)normalName:(NSDictionary *)dic
{
    
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *normal = dic[@"normal"];
    for (NSDictionary *dic1 in normal) {
        AnchorModel *model = [[AnchorModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model.name];
    }
    return arr;
}


+(NSMutableArray *)songer:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *famous = dic[@"famous"];
    NSDictionary *dic1 = famous[3];
    NSArray *list = dic1[@"list"];
    for (NSDictionary *dic2 in list) {
        AnchorModel *model = [[AnchorModel alloc]init];
        [model setValuesForKeysWithDictionary:dic2];
        [arr addObject:model];
    }
    return arr;
}


+(NSMutableArray *)famousTitle:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *famous = dic[@"famous"];
    for (NSDictionary *dic1 in famous) {
        AnchorModel *model = [[AnchorModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model.title];
    }
    return arr;
}

+(NSMutableArray *)normalTitle:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *normal = dic[@"normal"];
    for (NSDictionary *dic1 in normal) {
        AnchorModel *model = [[AnchorModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model.title];
    }
    return arr;
}



+(NSMutableArray *)famous:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *famous = dic[@"famous"];
    for (NSDictionary *dic1 in famous) {
        AnchorModel *model = [[AnchorModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        NSMutableArray *arr2 = [NSMutableArray array];
        NSDictionary *dic2 = [NSDictionary dictionaryWithObject:arr2 forKey:model.title];
        NSArray *list = dic1[@"list"];
        for (NSDictionary *dic3 in list) {
            AnchorModel *model = [[AnchorModel alloc]init];
            [model setValuesForKeysWithDictionary:dic3];
            [arr2 addObject:model];
            
        }
        [arr addObject:dic2];
    }
    return arr;
}

+(NSMutableArray *)normal:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *famous = dic[@"normal"];
    for (NSDictionary *dic1 in famous) {
        AnchorModel *model = [[AnchorModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        NSMutableArray *arr2 = [NSMutableArray array];
        NSDictionary *dic2 = [NSDictionary dictionaryWithObject:arr2 forKey:model.title];
        NSArray *list = dic1[@"list"];
        
        for (int i = 0; i < 3; i++) {
            AnchorModel *model = [[AnchorModel alloc]init];
            NSDictionary *dic3 = [NSDictionary dictionary];
            dic3 = list[i];
            
            [model setValuesForKeysWithDictionary:dic3];
            [arr2 addObject:model];
        }
        
        //        for (NSDictionary *dic3 in list) {
        //            AnchorModel *model = [[AnchorModel alloc]init];
        //            [model setValuesForKeysWithDictionary:dic3];
        //            [arr2 addObject:model];
        //        }
        
        
        [arr addObject:dic2];
    }
    return arr;
}


+(NSMutableArray *)moreSuperStar:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *list = dic[@"list"];
    for (NSDictionary *dic1 in list) {
        AnchorModel *model = [[AnchorModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model];
    }
    return arr;
}


+(NSMutableArray *)moreNormal:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *normal = dic[@"normal"];
    for (NSDictionary *dic1 in normal) {
        AnchorModel *model = [[AnchorModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model];
    }
    return arr;
}




@end
