//
//  ContentIntroductTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ContentIntroductTableViewCell.h"

@implementation ContentIntroductTableViewCell

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
        self.introduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 30)];
       self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 40, 40, 40)];
        [self.imageV.layer setMasksToBounds:YES];
        [self.imageV.layer setCornerRadius:20];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 40, 100, 20)];
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 65, 200, 10)];
        self.numberLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 85, kScreenWidth - 30, 60)];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.numberOfLines = 0;
        

        [self.contentView addSubview:self.introduceLabel];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}


-(void)creatPayCell:(DetailPayModel *)model
{
    self.introduceLabel.text = @"主播介绍";
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.smallLogo]];
    self.nameLabel.text = model.nickname;
    CGFloat f = [model.followers floatValue];
    self.numberLabel.text = [NSString stringWithFormat:@"已被%.1f万人关注",f/10000];
    self.titleLabel.text = model.personalSignature;
}

-(void)creatPinglun:(DetailPayModel *)model
{
    self.imageV.frame = CGRectMake(5, 10, 40, 40);
    self.nameLabel.frame = CGRectMake(50, 5, kScreenWidth - 100, 40);
    self.numberLabel.frame = CGRectMake(50, 40, 200, 10);
    self.titleLabel.frame = CGRectMake(5, 55, kScreenWidth - 30, 60);
   [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.smallHeader] placeholderImage:[UIImage imageNamed:@"1004.jpg"]];
    self.nameLabel.text = model.nickname;
    self.numberLabel.text = [NSString stringWithFormat:@"%@分",model.album_score];
    self.titleLabel.text = model.content;
    
}




@end
