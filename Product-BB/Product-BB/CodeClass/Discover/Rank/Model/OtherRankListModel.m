//
//  OtherRankListModel.m
//  Product-BB
//
//  Created by 林建 on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "OtherRankListModel.h"

@implementation OtherRankListModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(NSMutableArray *)ModelConfigureWithJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *Arr = [NSMutableArray array];
    NSArray *datas = jsonDic[@"datas"];
    NSDictionary *Dic = datas[1];
    NSArray *arr = Dic[@"list"];
    for (NSDictionary *dic in arr) {
        OtherRankListModel *model = [[OtherRankListModel alloc]init];
        NSArray *first = dic[@"firstKResults"];
        NSDictionary *fd1 = first[0];
        model.title1 = fd1[@"title"];
        NSDictionary *fd2 = first[1];
        model.title2 = fd2[@"title"];
        [model setValuesForKeysWithDictionary:dic];
        [Arr addObject:model];
    }
    
    return Arr;
}
@end
