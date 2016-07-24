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
//        model.albumId = dic[@"albumId"];
        model.inter = 3;
        model.isPaid = 0;
        model.row = 0;
        model.nickname = dic[@"nickname"];
        model.uid = dic[@"uid"];
        model.uid = 0;
        model.displayPrice = 0;
        [model setValuesForKeysWithDictionary:dic];
        [Arr addObject:model];
    }
    return Arr;
}
@end
