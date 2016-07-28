//
//  PlayListTableViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BroadMusicModel.h"

@interface PlayListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *playImageV;
@property (nonatomic, strong) UIImageView *downloadImageV;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)cellConfigureWithModel:(BroadMusicModel *)model;

//        self.activityView = [[MusicActivityView alloc]initWithFrame:CGRectMake(100, 15, 30, 30)];
//        self.activityView.numberOfRect = 4;
//        self.activityView.rectBackgroundColor = [UIColor orangeColor];
//        self.activityView.defaultSize = self.activityView.frame.size;
//        self.activityView.space = 2;
//        [self.activityView startAnimation];

@end
