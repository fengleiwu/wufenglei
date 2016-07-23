//
//  MyPlayerManager.h
//  Product- A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

// 播放模式
typedef NS_ENUM(NSInteger, PlayType){
    SignlePlay,
    RandomPlay,
    ListPlay
};
// 播放状态
typedef NS_ENUM(NSInteger, PlayState){
    Play,
    Pause
};
typedef void(^Block)();

//// 接收播放页面的三个参数，传到最底部的 button
typedef void (^BlockArray)(NSMutableArray *);
typedef void (^BlockImage)(NSString *);
typedef void (^BlockBool)(BOOL);
typedef void (^BlockBoolDownload)(BOOL);
typedef void (^BlockDataImage)(UIImage *);

@interface MyPlayerManager : NSObject

@property(nonatomic,assign)PlayState playState;
@property(nonatomic,assign)PlayType playType;
@property(nonatomic,strong)AVPlayer *avPlayer;
@property(nonatomic,strong)NSMutableArray *musicLists;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)float currentTime;
@property(nonatomic,assign)float totalTime;

// 接收播放的 URL，判断第二次播放的是否是同一个。
@property(nonatomic,strong)NSString *playingURL;
// 接收播放页面的三个参数，传到最底部的 button
@property (nonatomic, copy)BlockArray blockWithArray;
@property (nonatomic, copy)BlockImage blockWithImage;
@property (nonatomic, copy)BlockBool blockWithBool;
// 如果是下载过的，需要获取本地数据
@property (nonatomic,copy)BlockBoolDownload BlockBoolDownload;
@property (nonatomic, copy)BlockDataImage BlockDataImage;

+ (MyPlayerManager *)defaultManager;

- (void)seekToSecondsWith:(float)seconds;
- (float)currentTime;
- (float)totalTime;
- (void)lastMusic;
- (void)nextMusic;
-(void)changeMusicWith:(NSInteger )index;
-(void)playerDidFinish;
- (void)play;
- (void)pause;
- (void)stop;

@end
