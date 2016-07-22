//
//  DownLoadMusicTableViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMusicDownLoadTable.h"
#import "AlbumDetailModel.h"

@interface DownLoadMusicTableViewCell : UITableViewCell


@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *titleL;
@property(nonatomic , strong)UILabel *fuTitleL;
@property(nonatomic , strong)UIButton *numberBtn;
@property(nonatomic , strong)UIButton *likeBtn;
@property(nonatomic , strong)UIButton *conmentBtn;
@property(nonatomic , strong)UILabel *label1;
@property(nonatomic , strong)UILabel *label2;
@property(nonatomic , strong)UILabel *label3;
@property(nonatomic , strong)UIButton *rubbishBtn;

@property(nonatomic , strong)UIProgressView *progress;



-(void)creatCell:(NSArray *)arr;


-(void)creatDownloadingCell:(AlbumDetailModel *)model;


@end
