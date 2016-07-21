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

//typedef NS_ENUM(NSInteger, DownloadType){
//    UnDownload,
//    Downloadimg,
//    DownloadPause,
//    DiDdwonload
//};

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
//@property(nonatomic,assign)DownloadType downloadType;



@end
