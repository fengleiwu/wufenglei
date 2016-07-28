//
//  attentionFanZanModel.m
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/17.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "attentionFanZanModel.h"

@implementation attentionFanZanModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)guanzhu:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *list = dic[@"list"];
    for (NSDictionary *dic  in list) {
        attentionFanZanModel *model = [[attentionFanZanModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
}

//+(NSMutableArray *)fensi:(NSDictionary *)dic
//{
//    NSMutableArray *arr = [NSMutableArray array];
//    NSArray *list = dic[@"list"];
//    for (NSDictionary *dic in list) {
//        attentionFanZanModel *model = [[attentionFanZanModel alloc]init];
//        [model setValuesForKeysWithDictionary:dic];
//        [arr addObject:model];
//    }
//    return arr;
//}
//
//+(NSMutableArray *)zanguo:(NSDictionary *)dic
//{
//    NSMutableArray *arr = [NSMutableArray array];
//    NSArray *list = dic[@"list"];
//    for (NSDictionary *dic in list) {
//        attentionFanZanModel *model = [[attentionFanZanModel alloc]init];
//        [model setValuesForKeysWithDictionary:dic];
//        [arr addObject:model];
//    }
//    return arr;
//}


@end
