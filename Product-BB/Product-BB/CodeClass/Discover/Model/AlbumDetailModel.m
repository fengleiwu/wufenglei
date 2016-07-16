//
//  AlbumDetailModel.m
//  Product-BB
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AlbumDetailModel.h"

@implementation AlbumDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


+(AlbumDetailModel *)album:(NSDictionary *)dic
{
    NSDictionary *data = dic[@"data"];
    NSDictionary *album = data[@"album"];
    AlbumDetailModel *model = [[AlbumDetailModel alloc]init];
    [model setValuesForKeysWithDictionary:album];
    return model;
}


+(NSMutableArray *)tracks:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *data = dic[@"data"];
    NSDictionary *tracks = data[@"tracks"];
    NSArray *list = tracks[@"list"];
    for (NSDictionary *dic1 in list) {
        AlbumDetailModel *model = [[AlbumDetailModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model];
    }
    return arr;
    
}

+(AlbumDetailModel *)user:(NSDictionary *)dic
{
    NSDictionary *data = dic[@"data"];
    NSDictionary *user = data[@"user"];
    AlbumDetailModel *model = [[AlbumDetailModel alloc]init];
    [model setValuesForKeysWithDictionary:user];
    return model;
}


+(NSMutableArray *)payArray:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *data = dic[@"data"];
    NSArray *list = data[@"list"];
    for (NSDictionary *dic1 in list) {
        AlbumDetailModel *model = [[AlbumDetailModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model];
    }
    return arr;
}

@end
