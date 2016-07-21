//
//  recommendMoreTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "recommendMoreTableViewCell.h"

@implementation recommendMoreTableViewCell

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
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
        self.bigLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, kScreenWidth - 10 - 100 - 10 - 40, 40)];
        self.middleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 60, kScreenWidth - 10 - 100 - 10 - 40, 20)];
        self.bigLabel.font = [UIFont systemFontOfSize:17];
        self.middleLabel.font = [UIFont systemFontOfSize:14];
        self.imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(120, 90, 20, 20)];
        self.imageV1.image = [UIImage imageNamed:@"play"];
        self.small1Label = [[UILabel alloc]init];
        self.imageV2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"audio_wave"]];
        self.small2Label = [[UILabel alloc]init];
        self.small2Label.font = [UIFont systemFontOfSize:10];
        self.small1Label.font = [UIFont systemFontOfSize:10];
        self.btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btn.frame = CGRectMake(kScreenWidth - 40, 0, 40, 120);
        [self.btn setTitle:@">" forState:(UIControlStateNormal)];
        [self.btn setTintColor:[UIColor grayColor]];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.bigLabel];
        [self.contentView addSubview:self.middleLabel];
        [self.contentView addSubview:self.imageV1];
        [self.contentView addSubview:self.imageV2];
        [self.contentView addSubview:self.small1Label];
        [self.contentView addSubview:self.small2Label];
        [self.contentView addSubview:self.btn];
    }
    return self;
}
-(void)creatCell:(recommendMoreModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverMiddle]];
    self.bigLabel.text = model.title;
    self.middleLabel.text = model.intro;
    self.small2Label.text = [NSString stringWithFormat:@"%@集",model.tracks];
    CGFloat f = [model.playsCounts floatValue] / 10000;
    if (f > 10000) {
        NSString *st = [NSString stringWithFormat:@"%.1f亿",f / 1000];
        CGFloat s = [AdjustHeight adjustHeightByString:st width:20 font:10];
        self.small1Label.frame = CGRectMake(140, 90, s + 15, 20);
        self.imageV2.frame = CGRectMake(140 + s + 20 , 90, 20, 20);
        self.small2Label.frame = CGRectMake(140 + s + 20 + 20 + 5, 90, 100, 20);
        self.small1Label.text = st;
    }else
    {
        NSString *st = [NSString stringWithFormat:@"%.1f万",f];
        CGFloat s = [AdjustHeight adjustHeightByString:st width:20 font:10];
        self.small1Label.frame = CGRectMake(140, 90, s + 20, 20);
        self.imageV2.frame = CGRectMake(140 + s + 20 , 90, 20, 20);
        self.small2Label.frame = CGRectMake(140 + s + 20 + 20 + 5, 90, 100, 20);
        self.small1Label.text = st;

    }
    
}

-(void)creatListenCell:(ListenDetailModel *)model
{

    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.albumCoverUrl290]];
    self.bigLabel.text = model.title;
    self.middleLabel.text = model.intro;
    self.small2Label.text = [NSString stringWithFormat:@"%@集",model.tracksCounts];
    CGFloat f = [model.playsCounts floatValue] / 10000;
    if (f <= 1) {
        NSString *st = [NSString stringWithFormat:@"%@",model.playsCounts];
        CGFloat s = [AdjustHeight adjustHeightByString:st width:20 font:10];
        self.small1Label.frame = CGRectMake(140, 90, s + 15, 20);
        self.imageV2.frame = CGRectMake(140 + s + 20 , 90, 20, 20);
        self.small2Label.frame = CGRectMake(140 + s + 20 + 20 + 5, 90, 100, 20);
        self.small1Label.text = st;
    }
    if (f > 10000) {
        NSString *st = [NSString stringWithFormat:@"%.1f亿",f / 1000];
        CGFloat s = [AdjustHeight adjustHeightByString:st width:20 font:10];
        self.small1Label.frame = CGRectMake(140, 90, s + 15, 20);
        self.imageV2.frame = CGRectMake(140 + s + 20 , 90, 20, 20);
        self.small2Label.frame = CGRectMake(140 + s + 20 + 20 + 5, 90, 100, 20);
        self.small1Label.text = st;
    }else
    {
        NSString *st = [NSString stringWithFormat:@"%.1f万",f];
        CGFloat s = [AdjustHeight adjustHeightByString:st width:20 font:10];
        self.small1Label.frame = CGRectMake(140, 90, s + 20, 20);
        self.imageV2.frame = CGRectMake(140 + s + 20 , 90, 20, 20);
        self.small2Label.frame = CGRectMake(140 + s + 20 + 20 + 5, 90, 100, 20);
        self.small1Label.text = st;
        
    }


}

-(void)creatAttentionMiddle:(attentionModel *)model
{
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverLarge]];
    self.bigLabel.text = model.title;
    NSString *s = model.updatedAt;
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:[s doubleValue]/1000];
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //    [formatter setDateFormat:@"MM/dd/yyyy"];
    //NSString *show = [formatter stringFromDate:d];
    self.middleLabel.text = [NSString stringWithFormat:@"最后更新时间:%@",d];
    self.small2Label.text = [NSString stringWithFormat:@"%@集",model.tracks];
    CGFloat f = [model.playTimes floatValue] / 10000;
    if (f <= 1) {
        NSString *st = [NSString stringWithFormat:@"%@",model.playTimes];
        CGFloat s = [AdjustHeight adjustHeightByString:st width:20 font:10];
        self.small1Label.frame = CGRectMake(140, 90, s + 15, 20);
        self.imageV2.frame = CGRectMake(140 + s + 20 , 90, 20, 20);
        self.small2Label.frame = CGRectMake(140 + s + 20 + 20 + 5, 90, 100, 20);
        self.small1Label.text = st;
    }
    if (f > 10000) {
        NSString *st = [NSString stringWithFormat:@"%.1f亿",f / 1000];
        CGFloat s = [AdjustHeight adjustHeightByString:st width:20 font:10];
        self.small1Label.frame = CGRectMake(140, 90, s + 15, 20);
        self.imageV2.frame = CGRectMake(140 + s + 20 , 90, 20, 20);
        self.small2Label.frame = CGRectMake(140 + s + 20 + 20 + 5, 90, 100, 20);
        self.small1Label.text = st;
    }else
    {
        NSString *st = [NSString stringWithFormat:@"%.1f万",f];
        CGFloat s = [AdjustHeight adjustHeightByString:st width:20 font:10];
        self.small1Label.frame = CGRectMake(140, 90, s + 20, 20);
        self.imageV2.frame = CGRectMake(140 + s + 20 , 90, 20, 20);
        self.small2Label.frame = CGRectMake(140 + s + 20 + 20 + 5, 90, 100, 20);
        self.small1Label.text = st;
        
    }
    
    
}


@end
