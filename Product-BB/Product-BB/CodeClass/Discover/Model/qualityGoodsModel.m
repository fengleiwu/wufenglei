//
//  qualityGoodsModel.m
//  Product-BB
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "qualityGoodsModel.h"

@implementation qualityGoodsModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}





+(NSMutableSet *)set:(NSDictionary *)dic
{
    
    NSMutableSet *set = [NSMutableSet set];
    NSArray *list = dic[@"list"];
    for (NSDictionary *dic1 in list) {
        qualityGoodsModel *model = [[qualityGoodsModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        NSString *s = model.releasedAt;
        NSDate *d = [NSDate dateWithTimeIntervalSince1970:[s doubleValue]/1000];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
      [formatter setDateFormat:@"MM/dd/yyyy"];
        NSString *show = [formatter stringFromDate:d];
        [set addObject:show];
    }
    return set;
}


+(NSMutableArray *)qualityGood:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *list = dic[@"list"];
    for (NSDictionary *dic1 in list) {
        qualityGoodsModel *model = [[qualityGoodsModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        NSString *s = model.releasedAt;
        NSDate *d = [NSDate dateWithTimeIntervalSince1970:[s doubleValue]/1000];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MM/dd/yyyy"];
        NSString *show = [formatter stringFromDate:d];
        model.releasedAt = show;
        [arr addObject:model];
    }
    return arr;
}







//1468489338000 1468489272000 1468488055000 1468403033000 1468313756000 1468308961000 1468291791000

@end
