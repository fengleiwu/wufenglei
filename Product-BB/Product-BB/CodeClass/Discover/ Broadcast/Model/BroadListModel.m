//
//  BroadListModel.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BroadListModel.h"

@implementation BroadListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic {
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *dataArray = dataDic[@"data"];
    for (NSDictionary *dic in dataArray) {
        BroadListModel *model = [[BroadListModel alloc]init];
        model.idd = dic[@"id"];
        model.playUrl1 = dic[@"playUrl"][@"aac24"];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}

@end
