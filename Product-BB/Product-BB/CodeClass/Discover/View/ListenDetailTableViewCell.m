//
//  ListenDetailTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ListenDetailTableViewCell.h"

@implementation ListenDetailTableViewCell

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
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
        [self.imageV.layer setMasksToBounds:YES];
        [self.imageV.layer setCornerRadius:40];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, kScreenWidth - 150, 60)];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.numberOfLines = 0;
        UIImageView *person = [[UIImageView alloc]initWithFrame:CGRectMake(100, 65, 20, 20)];
        person.image = [UIImage imageNamed:@"guest_male"];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 65, kScreenWidth - 150 - 25, 20)];
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(100, 90, 20, 20)];
        imageV.image = [UIImage imageNamed:@"play"];
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 90, 60, 20)];
        self.numberLabel.font = [UIFont systemFontOfSize:10];
        self.like = [[UIImageView alloc]initWithFrame:CGRectMake(170, 90, 20, 20)];
        self.like.image = [UIImage imageNamed:@"like_outline"];
        self.likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(195, 90, 50, 20)];
        self.likeLabel.font = [UIFont systemFontOfSize:10];
        self.contact = [[UIImageView alloc]initWithFrame:CGRectMake(230, 90, 20, 20)];
        self.contact.image = [UIImage imageNamed:@"speech_bubble"];
        self.commentsLabel = [[UILabel alloc]initWithFrame:CGRectMake(255, 90, 50, 20)];
        self.commentsLabel.font = [UIFont systemFontOfSize:10];
        self.downLoadBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.downLoadBtn.frame = CGRectMake(kScreenWidth - 40, 45, 30, 30);
        [self.downLoadBtn setImage:[UIImage imageNamed:@"download"] forState:(UIControlStateNormal)];
        [self.downLoadBtn setTintColor:[UIColor blackColor]];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:person];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:imageV];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.likeLabel];
        [self.contentView addSubview:self.like];
        [self.contentView addSubview:self.contact];
        [self.contentView addSubview:self.commentsLabel];
        [self.contentView addSubview:self.downLoadBtn];
    }
    return self;
}



-(void)creatListenCell12:(AlbumDetailModel *)model
{
    if (model.coverLarge == nil) {
        
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverSmall]];
    }else{
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverLarge]];
        
    }
    self.titleLabel.text = model.title;
    self.nameLabel.text = model.nickname;
    [self.contentView addSubview:self.like];
    CGFloat f = [model.playsCounts floatValue];
    if (f / 10000 >= 1) {
        self.numberLabel.text = [NSString stringWithFormat:@"%.1f万",f / 1000];
    }else{
        self.numberLabel.text = [NSString stringWithFormat:@"%@",model.playsCounts];
    }
    self.likeLabel.text = [NSString stringWithFormat:@"%@",model.favoritesCounts];
    self.commentsLabel.text = [NSString stringWithFormat:@"%@",model.commentsCounts];
}

-(void)creatListenCell:(ListenDetailModel *)model
{
    if (model.coverLarge == nil) {
        
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverSmall]];
    }else{
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverLarge]];

    }
    self.titleLabel.text = model.title;
    self.nameLabel.text = model.nickname;
    [self.contentView addSubview:self.like];
    CGFloat f = [model.playsCounts floatValue];
    if (f / 10000 >= 1) {
        self.numberLabel.text = [NSString stringWithFormat:@"%.1f万",f / 1000];
    }else{
        self.numberLabel.text = [NSString stringWithFormat:@"%@",model.playsCounts];
    }
    self.likeLabel.text = [NSString stringWithFormat:@"%@",model.favoritesCounts];
    self.commentsLabel.text = [NSString stringWithFormat:@"%@",model.commentsCounts];
}

-(void)creatAttentionCell:(attentionModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverLarge]];
    self.titleLabel.text = model.title;
    self.nameLabel.text = model.nickname;
    CGFloat f = [model.playtimes floatValue];
    if (f / 10000 >= 1) {
        self.numberLabel.text = [NSString stringWithFormat:@"%.1f万",f / 1000];
    }else{
        self.numberLabel.text = [NSString stringWithFormat:@"%@",model.playtimes];
    }
    self.commentsLabel.frame = CGRectMake(195, 90, 50, 20);
    self.contact.frame = CGRectMake(170, 90, 20, 20);
    self.commentsLabel.text = [NSString stringWithFormat:@"%@",model.comments];
    [self.like removeFromSuperview];
}


-(void)creatZanguoCell:(attentionFanZanModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverMiddle]];
    self.titleLabel.text = model.title;
    self.nameLabel.text = model.nickname;
    CGFloat f = [model.playtimes floatValue];
    if (f / 10000 >= 1) {
        self.numberLabel.text = [NSString stringWithFormat:@"%.1f万",f / 1000];
    }else{
        self.numberLabel.text = [NSString stringWithFormat:@"%@",model.playtimes];
    }
    self.commentsLabel.frame = CGRectMake(195, 90, 50, 20);
    self.contact.frame = CGRectMake(170, 90, 20, 20);
    self.commentsLabel.text = [NSString stringWithFormat:@"%@",model.comments];
    [self.like removeFromSuperview];

    

}



@end
