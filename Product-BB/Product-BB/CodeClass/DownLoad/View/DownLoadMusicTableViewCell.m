//
//  DownLoadMusicTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DownLoadMusicTableViewCell.h"

@implementation DownLoadMusicTableViewCell

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
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self.imageV.layer setMasksToBounds:YES];
        [self.imageV.layer setCornerRadius:30];
        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(80, 5, kScreenWidth - 80, 40)];
        self.titleL.font = [UIFont systemFontOfSize:15];
        self.titleL.numberOfLines = 0;
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn.frame = CGRectMake(80, 50, 20, 20);
        [btn setTintColor:[UIColor grayColor]];
        [btn setImage:[UIImage imageNamed:@"guest_male"] forState:(UIControlStateNormal)];
        self.fuTitleL = [[UILabel alloc]initWithFrame:CGRectMake(105, 40, kScreenWidth - 150, 40)];
        self.fuTitleL.font = [UIFont systemFontOfSize:12];
        self.fuTitleL.numberOfLines = 0;
        self.fuTitleL.textColor = [UIColor grayColor];
        self.numberBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.numberBtn.frame = CGRectMake(80, 80, 20, 20);
        [self.numberBtn setTintColor:[UIColor grayColor]];
        [self.numberBtn setImage:[UIImage imageNamed:@"play"] forState:(UIControlStateNormal)];
        [self.numberBtn setTintColor:[UIColor grayColor]];
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 80, 70, 20)];
        self.label1.font = [UIFont systemFontOfSize:10];
        self.label1.textColor = [UIColor grayColor];
        self.likeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.likeBtn.frame = CGRectMake(145, 80, 20, 20);
        [self.likeBtn setImage:[UIImage imageNamed:@"like_outline"] forState:(UIControlStateNormal)];
        [self.likeBtn setTintColor:[UIColor grayColor]];
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(165, 80, 70, 20)];
        self.label2.textColor = [UIColor grayColor];
        self.label2.font = [UIFont systemFontOfSize:10];
        self.conmentBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.conmentBtn.frame = CGRectMake(200, 80, 20, 20);
        [self.conmentBtn setImage:[UIImage imageNamed:@"comments"] forState:(UIControlStateNormal)];
        [self.conmentBtn setTintColor:[UIColor grayColor]];
        self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(220, 80, 70, 20)];
        self.label3.font = [UIFont systemFontOfSize:10];
        self.label3.textColor = [UIColor grayColor];
        self.rubbishBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.rubbishBtn.frame = CGRectMake(kScreenWidth - 40, 40, 30, 30);
        [self.rubbishBtn setImage:[UIImage imageNamed:@"trash"] forState:(UIControlStateNormal)];
        [self.rubbishBtn setTintColor:[UIColor grayColor]];
        self.progress = [[UIProgressView alloc]initWithProgressViewStyle:(UIProgressViewStyleBar)];
        self.progress.frame = CGRectMake(80, 110, 200, 20);
        self.progress.tintColor = [UIColor redColor];
        self.progress.trackTintColor = [UIColor blackColor];
        [self.contentView addSubview:self.progress];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:btn];
        [self.contentView addSubview:self.fuTitleL];
        [self.contentView addSubview:self.numberBtn];
        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.likeBtn];
        [self.contentView addSubview:self.label2];
        [self.contentView addSubview:self.conmentBtn];
        [self.contentView addSubview:self.label3];
        [self.contentView addSubview:self.rubbishBtn];
        
    }
    return self;
}


-(void)creatCell:(NSArray *)arr
{
    self.progress.hidden = YES;
    self.rubbishBtn.hidden = NO;
    self.imageV.image = [UIImage imageWithData:arr[2]];
    
    //[self.imageV sd_setImageWithURL:[NSURL URLWithString:arr[2]]];
    self.titleL.text = arr[4];
    self.fuTitleL.text = arr[0];
    CGFloat f = [arr[5] floatValue];
    if (f > 10000) {
        self.label1.text = [NSString stringWithFormat:@"%.1f万",f / 10000];
    }if (f/10000 > 10000) {
        self.label1.text = [NSString stringWithFormat:@"%.1f亿",f / 10000 / 10000];
    }if (f <= 10000) {
        self.label1.text = [NSString stringWithFormat:@"%@",arr[5]];
    }
    
    CGFloat g = [arr[8] floatValue];
    if (g > 10000) {
        self.label2.text = [NSString stringWithFormat:@"%.1f万",g / 10000];
    }if (g <= 10000) {
        self.label2.text = [NSString stringWithFormat:@"%@",arr[8]];
    }
    
    CGFloat h = [arr[7] floatValue];
    if (h > 10000) {
        self.label3.text = [NSString stringWithFormat:@"%.1f万",h / 10000];
    }if (h <= 10000) {
        self.label3.text = [NSString stringWithFormat:@"%@",arr[7]];
    }
}


-(void)creatDownloadingCell:(AlbumDetailModel *)model
{
    self.progress.hidden = NO;
    self.rubbishBtn.hidden = YES;
    if (model.smallLogo == nil) {
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] placeholderImage:[UIImage imageNamed:@"1004.jpg"]];
    }else{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.smallLogo]];
    }
    self.titleL.text = model.title;
    self.fuTitleL.text = model.nickname;
    if (model.playtimes == nil) {
        CGFloat f = [model.playsCounts floatValue];
        if (f > 10000) {
            self.label1.text = [NSString stringWithFormat:@"%.1f万",f / 10000];
        }if (f/10000 > 10000) {
            self.label1.text = [NSString stringWithFormat:@"%.1f亿",f / 10000 / 10000];
        }if (f <= 10000) {
            self.label1.text = [NSString stringWithFormat:@"%@",model.playsCounts];
        }

    }else { CGFloat f = [model.playtimes floatValue];
    if (f > 10000) {
        self.label1.text = [NSString stringWithFormat:@"%.1f万",f / 10000];
    }if (f/10000 > 10000) {
        self.label1.text = [NSString stringWithFormat:@"%.1f亿",f / 10000 / 10000];
    }if (f <= 10000) {
        self.label1.text = [NSString stringWithFormat:@"%@",model.playtimes];
    }
    }
    
    if (model.likes == nil) {
        CGFloat g = [model.favoritesCounts floatValue];
        if (g > 10000) {
            self.label2.text = [NSString stringWithFormat:@"%.1f万",g / 10000];
        }if (g <= 10000) {
            self.label2.text = [NSString stringWithFormat:@"%@",model.favoritesCounts];
        }

    }else{
    CGFloat g = [model.likes floatValue];
    if (g > 10000) {
        self.label2.text = [NSString stringWithFormat:@"%.1f万",g / 10000];
    }if (g <= 10000) {
        self.label2.text = [NSString stringWithFormat:@"%@",model.likes];
    }
}

    if (model.comments == nil) {
        CGFloat h = [model.commentsCounts floatValue];
        if (h > 10000) {
            self.label3.text = [NSString stringWithFormat:@"%.1f万",h / 10000];
        }if (h <= 10000) {
            self.label3.text = [NSString stringWithFormat:@"%@",model.commentsCounts];
        }
    }else{
    CGFloat h = [model.comments floatValue];
    if (h > 10000) {
        self.label3.text = [NSString stringWithFormat:@"%.1f万",h / 10000];
    }if (h <= 10000) {
        self.label3.text = [NSString stringWithFormat:@"%@",model.comments];
    }
    }
}



@end
