//
//  LocationModel.m
//  Product-BB
//
//  Created by 林建 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

+(NSMutableArray *)ModelConfigureWithJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *Arr = [NSMutableArray array];
    NSDictionary *data = jsonDic[@"data"];
    NSArray *arr = data[@"localRadios"];
    for (NSDictionary *dic in arr) {
        LocationModel *model = [[LocationModel alloc]init];
        model.idd = dic[@"id"];
        model.playUrl1 = dic[@"playUrl"][@"aac24"];
        [model setValuesForKeysWithDictionary:dic];
        [Arr addObject:model];
    }
    return Arr;
}


@end
