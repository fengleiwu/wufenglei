//
//  MyPlayerManager.m
//  Product- A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MyPlayerManager.h"
#import "BroadMusicModel.h"

@interface MyPlayerManager ()

@end

@implementation MyPlayerManager

+ (MyPlayerManager *)defaultManager{
    static MyPlayerManager *myPlayerManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myPlayerManger = [[MyPlayerManager alloc] init];
    });
    return myPlayerManger;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"first"]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first"];
            [[NSUserDefaults standardUserDefaults] setObject:@"refresh" forKey:@"playType"];
        }
        _playType = ListPlay;
        _playState = Pause;
    }
    return self;
}


// 设置数据
- (void)setMusicLists:(NSMutableArray *)musicLists{
    [_musicLists removeAllObjects];
    _musicLists = [musicLists mutableCopy];
    BroadMusicModel *model = _musicLists[_index];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:model.musicURL]];
    if (!_avPlayer) {
        // 没有，初始化
        _avPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
        _avPlayer.volume = 10;
    } else{
        // 有
//        [_avPlayer replaceCurrentItemWithPlayerItem:item];
    }
}

// 播放
- (void)play{
    [_avPlayer play];
    _playState = Play;
  
    
}
- (void)pause{
    [_avPlayer pause];
    _playState = Pause;
    
    // 通知，暂停后，改变底部按钮的图片
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pauseNotication" object:nil];
}

- (void)stop{
    [self seekToSecondsWith:0];
    _playState = Pause;
}

// 改变当前播放源的时间
- (void)seekToSecondsWith:(float)seconds{
    CMTime newTime = _avPlayer.currentTime;
    newTime.value = newTime.timescale * seconds;
    [_avPlayer seekToTime:newTime];
}


#pragma mark --- 时间获取
- (float)currentTime{
    if (_avPlayer.currentTime.timescale == 0) {
        return 0;
    }
    return _avPlayer.currentTime.value /_avPlayer.currentTime.timescale;
}
- (float)totalTime{
    if (_avPlayer.currentItem.duration.timescale == 0) {
        return 0;
    }
    return _avPlayer.currentItem.duration.value / _avPlayer.currentItem.duration.timescale;
}
//上一首
- (void)lastMusic{
    if (_playType == RandomPlay) {
        _index = arc4random() %_musicLists.count;
    } else {
        if (_index == 0) {
            _index = _musicLists.count - 1;
        } else{
            _index --;
        }
    }
    [self changeMusicWith:_index];
}
// 下一首
- (void)nextMusic{
    if (_playType == RandomPlay) {
        _index = arc4random() %_musicLists.count;
    } else {
        if (_index == _musicLists.count - 1) {
            _index = 0;
        } else {
            _index ++;
        }
    }
    [self changeMusicWith:_index];
}

// 根据index来切歌
-(void)changeMusicWith:(NSInteger )index{
    _index = index;
    BroadMusicModel *model = _musicLists[_index];
    if ([model.musicURL containsString:@"Caches/"]) {
        AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:model.musicURL]];
        [_avPlayer replaceCurrentItemWithPlayerItem:playerItem];
    } else{
        AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:model.musicURL]];
        [_avPlayer replaceCurrentItemWithPlayerItem:playerItem];
    }
    [self play];
}

-(void)playerDidFinish{
    if (_playType == SignlePlay) {
        BroadMusicModel *model = _musicLists[_index];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:model.musicURL]];
        [_avPlayer replaceCurrentItemWithPlayerItem:item];
    } else{
        [self nextMusic];
    }
}













@end
