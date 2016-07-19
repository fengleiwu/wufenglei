//
//  BroadMusicModel.h
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BroadListModel.h"
#import "LocationModel.h"
#import "RankModel.h"
#import "AlbumDetailModel.h"
#import "ListenDetailModel.h"
#import "attentionModel.h"

typedef NS_ENUM(NSInteger, DownloadType){
    UnDownload,
    Downloadimg,
    DownloadPause,
    DiDdwonload
};

@interface BroadMusicModel : NSObject

@property (nonatomic, strong) NSString *musicURL;
@property (nonatomic, strong) NSString *totalTitle;
@property (nonatomic, strong) NSString *liveTitle;
@property (nonatomic, strong) NSString *playCount;
@property (nonatomic, strong) NSString *bgImage;

+ (NSMutableArray *)modelCOnfigureWithLocationModel:(NSMutableArray *)modelArr;
+ (NSMutableArray *)modelCOnfigureWithRankModel:(NSMutableArray *)modelArr;
+ (NSMutableArray *)modelCOnfigureWithBroadlistModel:(NSMutableArray *)modelArr;
+ (NSMutableArray *)modelCOnfigureWithAlbumDetailModel:(NSMutableArray *)modelArr;
+ (NSMutableArray *)modelCOnfigureWithListenDetailModel:(NSMutableArray *)modelArr;
+ (NSMutableArray *)modelCOnfigureWithAttentionModel:(NSMutableArray *)modelArr;

@property(nonatomic,assign)BOOL isPlay;
@property(nonatomic,strong)NSString *savePath;
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,assign)DownloadType downloadType;





//+ (NSMutableArray *)modelCOnfigureWithModelArray_m3u8:(NSMutableArray *)modelArr;
//+ (NSMutableArray *)modelCOnfigureWithModelArray_playUrl64_mp3:(NSMutableArray *)modelArr;
//+ (NSMutableArray *)modelCOnfigureWithModelArray_playPath64_mp3:(NSMutableArray *)modelArr;

//// m3u8 url, 广播 model
//@property (nonatomic, strong) NSString *playUrl1;
//@property (nonatomic, strong) NSString *name;
//@property (nonatomic, strong) NSString *programName;
////@property (nonatomic, strong) NSString *playCount;
//@property (nonatomic, strong) NSString *coverSmall;
//
//// playUrl64 url, albumDetailModel
//@property (nonatomic, strong) NSString *playUrl64;
//@property (nonatomic, strong) NSString *nickname;
//@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) NSString *playtimes;
//@property (nonatomic, strong) NSString *coverMiddle;
//
//// playPath64 url, listenDetailModel,attentionModel
//// title.nickname.playsCounts.coverSmall.playPath64
////@property (nonatomic, strong) NSString *title;
////@property (nonatomic,strong) NSString *nickname;
//@property (nonatomic,strong) NSString *playsCounts;
////@property (nonatomic,strong) NSString *coverSmall;
//@property (nonatomic, strong) NSString *playPath64;


@end
