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
@property (nonatomic, strong) NSString *musicURL;
@property (nonatomic, strong) NSString *totalTitle;
@property (nonatomic, strong) NSString *liveTitle;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *bgImage;
*/

// 包含 m3u8 ，解析 model。
+ (NSMutableArray *)modelCOnfigureWithModelArray_m3u8:(NSMutableArray *)modelArr {
    NSMutableArray *array = [NSMutableArray array];
    for (BroadMusicModel *otherModel in modelArr) {
        BroadMusicModel *model = [[BroadMusicModel alloc]init];
        model.musicURL = otherModel.playUrl1;
        model.totalTitle = otherModel.name;
        model.liveTitle = otherModel.programName;
        model.playCount = otherModel.playCount;
        model.bgImage = otherModel.coverSmall;
        
        [array addObject:model];
    }
    return array;
}

// 解析 albumdetailModel,attentionModel
+ (NSMutableArray *)modelCOnfigureWithModelArray_playUrl64_mp3:(NSMutableArray *)modelArr {
    NSMutableArray *array = [NSMutableArray array];
    for (BroadMusicModel *otherModel in modelArr) {
        BroadMusicModel *model = [[BroadMusicModel alloc]init];
        model.musicURL = otherModel.playUrl64;
        model.totalTitle = otherModel.title;
        model.liveTitle = otherModel.nickname;
        model.playCount = otherModel.playtimes;
        model.bgImage = otherModel.coverMiddle;
        [array addObject:model];
    }
    return array;
}

// 解析 listenDetailModel/title.nickname.playsCounts.coverSmall.playPath64
+ (NSMutableArray *)modelCOnfigureWithModelArray_playPath64_mp3:(NSMutableArray *)modelArr {
    NSMutableArray *array = [NSMutableArray array];
    for (BroadMusicModel *otherModel in modelArr) {
        BroadMusicModel *model = [[BroadMusicModel alloc]init];
        model.musicURL = otherModel.playPath64;
        model.totalTitle = otherModel.title;
        model.liveTitle = otherModel.nickname;
        model.playCount = otherModel.playsCounts;
        model.bgImage = otherModel.coverSmall;
        [array addObject:model];
    }

    return array;
}

@end
