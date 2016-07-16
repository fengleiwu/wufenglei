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

// 广播 model
@property (nonatomic, strong) NSString *playUrl1; // playPath32
@property (nonatomic, strong) NSString *name;//nickname
@property (nonatomic, strong) NSString *programName;//title
@property (nonatomic, strong) NSString *playCount;// playsCounts
//@property (nonatomic, strong) NSString *coverSmall;//coverSmall
// 其他 model
@property (nonatomic, strong) NSString *playPath32;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *playsCounts;
@property (nonatomic, strong) NSString *coverSmall;

//@property (nonatomic, strong) NSString *coverLarge;
//@property (nonatomic,strong) NSString *idd;
//@property (nonatomic,strong) NSString *fmUid;
//@property (nonatomic,strong) NSString *programId;


@property(nonatomic,assign)BOOL isPlay;
@property(nonatomic,strong)NSString *savePath;
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,assign)DownloadType downloadType;

+ (NSMutableArray *)modelConfigureWithArray:(NSMutableArray *)modelArr;

@end
