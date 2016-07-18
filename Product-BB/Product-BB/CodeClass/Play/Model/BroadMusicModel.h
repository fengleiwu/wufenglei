//
//  BroadMusicModel.h
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

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


// m3u8 url, 广播 model
@property (nonatomic, strong) NSString *playUrl1;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *programName;
//@property (nonatomic, strong) NSString *playCount;
@property (nonatomic, strong) NSString *coverSmall;

// playUrl64 url, albumDetailModel
@property (nonatomic, strong) NSString *playUrl64;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *playtimes;
@property (nonatomic, strong) NSString *coverMiddle;


//@property (nonatomic, strong) NSString *coverLarge;
//@property (nonatomic,strong) NSString *idd;
//@property (nonatomic,strong) NSString *fmUid;
//@property (nonatomic,strong) NSString *programId;
//

@property(nonatomic,assign)BOOL isPlay;
@property(nonatomic,strong)NSString *savePath;
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,assign)DownloadType downloadType;


+ (NSMutableArray *)modelCOnfigureWithModelArray_m3u8:(NSMutableArray *)modelArr;
+ (NSMutableArray *)modelCOnfigureWithModelArray_playUrl64_mp3:(NSMutableArray *)modelArr;

@end
