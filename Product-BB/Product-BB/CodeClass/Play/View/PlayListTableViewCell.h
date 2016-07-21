//
//  PlayListTableViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BroadMusicModel.h"
#import "MusicActivityView.h"

@interface PlayListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *playImageV;
@property (nonatomic, strong) UIImageView *downloadImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL isPlay;
// 音频跳动的动画
@property (nonatomic, strong) MusicActivityView *activityView;

- (void)cellConfigureWithModel:(BroadMusicModel *)model;


@end
