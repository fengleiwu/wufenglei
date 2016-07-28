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
#pragma mark --- 获取 m3u8 格式的 URL。
+ (NSMutableArray *)modelCOnfigureWithLocationModel:(NSMutableArray *)modelArr {
    NSMutableArray *array = [NSMutableArray array];
    for (LocationModel *otherModel in modelArr) {
        BroadMusicModel *model = [[BroadMusicModel alloc]init];
        model.musicURL = otherModel.playUrl1;
        model.totalTitle = otherModel.name;
        model.liveTitle = otherModel.programName;
        model.playCount = otherModel.playCount;
        model.bgImage = otherModel.coverLarge;
        
        [array addObject:model];
    }
    return array;

}
+ (NSMutableArray *)modelCOnfigureWithRankModel:(NSMutableArray *)modelArr {
    NSMutableArray *array = [NSMutableArray array];
    for (RankModel *otherModel in modelArr) {
        BroadMusicModel *model = [[BroadMusicModel alloc]init];
        model.musicURL = otherModel.playUrl1;
        model.totalTitle = otherModel.name;
        model.liveTitle = otherModel.programName;
        model.playCount = otherModel.playCount;
        model.bgImage = otherModel.coverLarge;
        
        [array addObject:model];
    }
    return array;

}
+ (NSMutableArray *)modelCOnfigureWithBroadlistModel:(NSMutableArray *)modelArr {
    NSMutableArray *array = [NSMutableArray array];
    for (BroadListModel *otherModel in modelArr) {
        BroadMusicModel *model = [[BroadMusicModel alloc]init];
        model.musicURL = otherModel.playUrl1;
        model.totalTitle = otherModel.name;
        model.liveTitle = otherModel.programName;
        model.playCount = otherModel.playCount;
        model.bgImage = otherModel.coverLarge;
        
        [array addObject:model];
    }
    return array;

}
#pragma mark --- 获取 playUrl64 格式的 URL。
+ (NSMutableArray *)modelCOnfigureWithAlbumDetailModel:(NSMutableArray *)modelArr{
    NSMutableArray *array = [NSMutableArray array];
    for (AlbumDetailModel *otherModel in modelArr) {
        BroadMusicModel *model = [[BroadMusicModel alloc]init];
        model.musicURL = otherModel.playUrl64;
        model.totalTitle = otherModel.title;
        model.liveTitle = otherModel.nickname;
        model.playCount = otherModel.playtimes;
        model.bgImage = otherModel.coverLarge;
        [array addObject:model];
    }
    return array;
}

+ (NSMutableArray *)modelCOnfigureWithAttentionModel:(NSMutableArray *)modelArr {
    NSMutableArray *array = [NSMutableArray array];
    for (attentionModel *otherModel in modelArr) {
        BroadMusicModel *model = [[BroadMusicModel alloc]init];
        model.musicURL = otherModel.playUrl64;
        model.totalTitle = otherModel.title;
        model.liveTitle = otherModel.nickname;
        model.playCount = otherModel.playtimes;
        model.bgImage = otherModel.coverLarge;
        [array addObject:model];
    }
    return array;
}

#pragma mark --- 获取 playPath64 格式的 URL。
+ (NSMutableArray *)modelCOnfigureWithListenDetailModel:(NSMutableArray *)modelArr {
    NSMutableArray *array = [NSMutableArray array];
    for (ListenDetailModel *otherModel in modelArr) {
        BroadMusicModel *model = [[BroadMusicModel alloc]init];
        model.musicURL = otherModel.playPath64;
        model.totalTitle = otherModel.title;
        model.liveTitle = otherModel.nickname;
        model.playCount = otherModel.playsCounts;
        model.bgImage = otherModel.coverLarge;
        [array addObject:model];
    }
    
    return array;
}

@end
