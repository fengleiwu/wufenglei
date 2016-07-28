//
//  CateTypeModel.m
//  Product-BB
//
//  Created by 林建 on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CateTypeModel.h"

@implementation CateTypeModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic{
    NSMutableArray *Arr = [NSMutableArray array];
    NSArray *arr = [NSArray array];
    if ([jsonDic objectForKey:@"tab"]) {
        arr  = jsonDic[@"tab"];
    }
    if ([jsonDic objectForKey:@"categoryContents"]) {
     NSDictionary *listDic = jsonDic[@"keywords"];
        arr = listDic[@"list"];
    }
    if ([jsonDic objectForKey:@"categoryInfo"]) {
        arr = jsonDic[@"keywords"];
    }
    if ([jsonDic objectForKey:@"categories"]) {
        arr = jsonDic[@"categories"];
    }
    for (NSDictionary *dic in arr) {
        CateTypeModel *model = [[CateTypeModel alloc]init];
        model.keywordId = [NSString stringWithFormat:@"%ld",[dic[@"keywordId"] integerValue]];
        model.idd = [NSString stringWithFormat:@"%ld",[dic[@"id"] integerValue]];
        [model setValuesForKeysWithDictionary:dic];
        if ([model.name isEqualToString:@"推荐"]) {
            
        } else {
           [Arr addObject:model];  
        }
       
    }
    return Arr;
}
@end
