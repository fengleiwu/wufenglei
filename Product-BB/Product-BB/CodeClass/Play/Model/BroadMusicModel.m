//
//  BroadMusicModel.m
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BroadMusicModel.h"

@implementation BroadMusicModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

/*
 @property (nonatomic, strong) NSString *playUrl1; // playPath32
 @property (nonatomic, strong) NSString *name;//nickname
 @property (nonatomic, strong) NSString *programName;//title
 @property (nonatomic, strong) NSString *playCount;// playsCounts
 @property (nonatomic, strong) NSString *coverSmall;//coverSmall
 */
+ (NSMutableArray *)modelConfigureWithArray:(NSMutableArray *)modelArr {
    NSMutableArray *array = [NSMutableArray array];
    for (BroadMusicModel *dic in modelArr) {
        BroadMusicModel *model = [[BroadMusicModel alloc]init];
        model.playPath32 = dic.playUrl1;
        model.title = dic.programName;
        model.nickname = dic.name;
        model.playsCounts = dic.playCount;
        model.coverSmall = dic.coverSmall;
        [array addObject:model];
    }
    return array;
}


@end
