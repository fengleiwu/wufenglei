//
//  MusicManager.m
//  UI06Object
//
//  Created by lanou on 16/6/8.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MusicManager.h"
@implementation MusicManager

+ (MusicManager *)shareInstance
{
    static MusicManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MusicManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.player = [[AVPlayer alloc]init];
        
    }
    return self;
}

#pragma mark --- 控制音量 ---
- (void)playerVolumeWithVolumeFloat:(CGFloat)volumeFloat
{
    self.player.volume = volumeFloat;
}

-(void)playerPlay
{
    [self.player play];
    self.state = YES;
    
}

-(void)playerPause
{
    [self.player pause];
    self.state = NO;
}

#pragma mark --- 播放/切换歌曲 ---
- (void)replaceItemWithUrlString:(NSString *)urlString
{
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlString]];
    [self.player replaceCurrentItemWithPlayerItem:item];
    [self playerPlay];
}

#pragma mark --- 控制进度 ---
- (void)playerProgressWitProgressFloat:(CGFloat)progressFloat
{
    [self.player seekToTime:CMTimeMake(progressFloat, 1) completionHandler:^(BOOL finished) {
        [self playerPlay];
    }];
}

#pragma mark --- 播放/暂停 ---
- (void)playerPlayAndPause
{
    if (self.state == YES) {
        [self playerPause];
    }else{
        [self playerPlay];
    }
}

#pragma mark --- 上一首 ---
- (void)playerAbove
{
    if (self.inter == 0) {
        
        self.indter --;
    }else if (self.inter == 1) {
        self.indter = arc4random() % self.array.count;
    }else if (self.inter == 2) {
        self.indter = self.indter;
    }
    if (self.indter < 0) {
        self.indter = self.array.count - 1;
    }
}

#pragma mark --- 下一首 ---
- (void)playerNext
{
    if (self.inter == 0) {
        
        self.indter ++;
    }else if (self.inter == 1) {
        self.indter = arc4random() % self.array.count;
    }else if (self.inter == 2) {
        self.indter = self.indter;
    }
    if (self.indter > self.array.count - 1) {
        self.indter = 0;
    }
    
}

#pragma mark --- 自动播放下一首 ---
- (void)playerAutoNext
{
    if (self.inter == 0) {
        
        self.indter ++;
    }else if (self.inter == 1) {
        self.indter = arc4random() % self.array.count;
    }else if (self.inter == 2) {
        self.indter = self.indter;
    }    if (self.indter > self.array.count - 1) {
        self.indter = 0;
    }
}






@end
