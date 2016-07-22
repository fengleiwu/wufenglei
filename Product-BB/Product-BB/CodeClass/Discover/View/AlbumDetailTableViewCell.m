//
//  AlbumDetailTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AlbumDetailTableViewCell.h"

@implementation AlbumDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
        [self.imageV.layer setMasksToBounds:YES];
        [self.imageV.layer setCornerRadius:30];
//        self.activityView = [[MusicActivityView alloc]initWithFrame:CGRectMake(100, 15, 30, 30)];
//        self.activityView.numberOfRect = 4;
//        self.activityView.rectBackgroundColor = [UIColor orangeColor];
//        self.activityView.defaultSize = self.activityView.frame.size;
//        self.activityView.space = 2;
//        [self.activityView startAnimation];
        self.bigLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, kScreenWidth - 40 - 100, 50)];
        self.bigLabel.font = [UIFont systemFontOfSize:15];
        self.bigLabel.numberOfLines = 0;
        self.littleImageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 70, 20, 20)];
        self.littleImageV1.image = [UIImage imageNamed:@"play"];
        self.littleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(120, 70, 50, 20)];
        self.littleLabel1.font = [UIFont systemFontOfSize:10];
        self.littleImageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(160, 70, 20, 20)];
        self.littleImageV2.image = [UIImage imageNamed:@"comments"];
        self.littleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(180, 70, 50, 20)];
        self.littleLabel2.font = [UIFont systemFontOfSize:10];
        self.playLabel = [[UILabel alloc]initWithFrame:CGRectMake(220, 70, 80, 20)];
        self.playLabel.font = [UIFont systemFontOfSize:10];
        self.playLabel.textColor = [UIColor orangeColor];
        //self.playLabel.hidden = YES;
        self.downLoadBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.downLoadBtn.frame = CGRectMake(kScreenWidth - 40, 35, 30, 30);
        [self.downLoadBtn setImage:[UIImage imageNamed:@"download"] forState:(UIControlStateNormal)];
        self.downLoadBtn.tintColor = [UIColor blackColor];
        //[self.contentView addSubview:self.activityView];
        [self.contentView addSubview:self.bigLabel];
        [self.contentView addSubview:self.littleLabel2];
        [self.contentView addSubview:self.littleLabel1];
        [self.contentView addSubview:self.littleImageV2];
        [self.contentView addSubview:self.littleImageV1];
        [self.contentView addSubview:self.playLabel];
        [self.contentView addSubview:self.downLoadBtn];
        [self.contentView addSubview:self.imageV];
        
    }
    return self;
}

-(void)creatCell:(AlbumDetailModel *)model
{
//    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverLarge]];
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverLarge] placeholderImage:
     [UIImage imageNamed:@"1004.jpg"]];
    
    
    self.bigLabel.text = model.title;
    
    
    CGFloat f = [model.playtimes floatValue] / 10000;
    if (f <= 10000) {
        self.littleLabel1.text = [NSString stringWithFormat:@"%.1f",f];
    }
    if (f > 10000) {
        NSString *st = [NSString stringWithFormat:@"%.1f亿",f / 1000];
        //playLabel.text = st;
        self.littleLabel1.text = st;
    }else
    {
        NSString *st = [NSString stringWithFormat:@"%.1f万",f];
        //playLabel.text = st;
        self.littleLabel1.text = st;
    }

    self.littleLabel2.text = [NSString stringWithFormat:@"%@",model.comments];
    
}

@end
