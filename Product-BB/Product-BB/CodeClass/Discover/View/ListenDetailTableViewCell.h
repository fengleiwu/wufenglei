//
//  ListenDetailTableViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListenDetailModel.h"
#import "attentionModel.h"//关注界面最下面
#import "attentionFanZanModel.h"
#import "AlbumDetailModel.h"
@interface ListenDetailTableViewCell : UITableViewCell

@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *titleLabel;
@property(nonatomic , strong)UILabel *nameLabel;
@property(nonatomic , strong)UILabel *numberLabel;
@property(nonatomic , strong)UILabel *likeLabel;
@property(nonatomic , strong)UILabel *commentsLabel;
@property(nonatomic , strong)UIButton *downLoadBtn;
@property(nonatomic , strong)UIImageView *contact;
@property(nonatomic , strong)UIImageView *like;

-(void)creatListenCell:(ListenDetailModel *)model;

-(void)creatAttentionCell:(attentionModel *)model;


-(void)creatZanguoCell:(attentionFanZanModel *)model;

-(void)creatListenCell12:(AlbumDetailModel *)model;

@end
