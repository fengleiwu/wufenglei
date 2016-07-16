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
    NSArray *arr = jsonDic[@"keywords"];
    for (NSDictionary *dic in arr) {
        CateTypeModel *model = [[CateTypeModel alloc]init];
        model.keywordId = [NSString stringWithFormat:@"%ld",[dic[@"keywordId"] integerValue]];
        [model setValuesForKeysWithDictionary:dic];
        [Arr addObject:model];
    }
    return Arr;
}
@end
