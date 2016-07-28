//
//  HotTitleModel.m
//  Product-BB
//
//  Created by 林建 on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HotTitleModel.h"

@implementation HotTitleModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

+ (NSMutableArray *)modelConfigureWithDic:(NSDictionary *)jsonDic{
    NSMutableArray *Arr = [NSMutableArray array];
   
    NSArray *cat = jsonDic[@"categories"];
    for (NSDictionary *dic in cat) {
        HotTitleModel *model = [[HotTitleModel alloc]init];
        model.idd = dic[@"id"];
        model.keyy = dic[@"key"];
        [model setValuesForKeysWithDictionary:dic];
        [Arr addObject:model];
    }
    HotTitleModel *model = [[HotTitleModel alloc]init];
    model.name = @"总榜";
    model.idd = 0;
    model.keyy = @"1_57_ranking:album:subscribed:30:3";
    [Arr insertObject:model atIndex:0];
    return Arr;
}
@end
