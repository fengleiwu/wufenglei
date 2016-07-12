//
//  focusImagesModel.m
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "focusImagesModel.h"

@implementation focusImagesModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

+(NSMutableArray *)focusImages:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dic1 = dic[@"focusImages"];
    NSArray *list = dic1[@"list"];
    for (NSDictionary *dic2 in list) {
        focusImagesModel *model = [[focusImagesModel alloc]init];
        [model setValuesForKeysWithDictionary:dic2];
        [arr addObject:model];
    }
    return arr;
}


+(NSMutableArray *)editorRecommendAlbums:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dic1 = dic[@"editorRecommendAlbums"];
    NSArray *list = dic1[@"list"];
    for (NSDictionary *dic2 in list) {
        focusImagesModel *model = [[focusImagesModel alloc]init];
        [model setValuesForKeysWithDictionary:dic2];
        [arr addObject:model];
    }
    return arr;
}

+(NSMutableArray *)specialColumn:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dic1 = dic[@"specialColumn"];
    NSArray *list = dic1[@"list"];
    for (NSDictionary *dic2 in list) {
        focusImagesModel *model = [[focusImagesModel alloc]init];
        [model setValuesForKeysWithDictionary:dic2];
        [arr addObject:model];
    }
    return arr;
}

@end
