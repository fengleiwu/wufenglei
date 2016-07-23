//
//  AnchorSongerTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AnchorSongerTableViewCell.h"

@implementation AnchorSongerTableViewCell

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
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 80, 80)];
        [self.imageV.layer setMasksToBounds:YES];
        [self.imageV.layer setCornerRadius:40];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 15, 200, 40)];
        self.nameLabel.font = [UIFont systemFontOfSize:17];
        self.introduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 55, 170, 50)];
        self.introduceLabel.font = [UIFont systemFontOfSize:15];
        self.introduceLabel.numberOfLines = 0;
        
        self.img = [[UIImageView alloc]initWithFrame:CGRectMake(90, 115, 20, 20)];
        self.img.image = [UIImage imageNamed:@"audio_wave"];
        self.listLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 115, 40, 20)];
        self.listLabel.font = [UIFont systemFontOfSize:12];
        self.group = [[UIImageView alloc]initWithFrame:CGRectMake(170, 115, 20, 20)];
        self.group.image = [UIImage imageNamed:@"user_group_man_man"];
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(195, 115, 60, 20)];
        self.numberLabel.font = [UIFont systemFontOfSize:12];
        self.btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btn.frame = CGRectMake(kScreenWidth - 50, 40, 40, 50);
        [self.btn setImage:[UIImage imageNamed:@"add_user_group"] forState:(UIControlStateNormal)];
        [self.btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.btn setTitle:@"加关注" forState:(UIControlStateNormal)];
        [self.btn setTitleEdgeInsets:UIEdgeInsetsMake(35, -35, 0, 0)];
        self.btn.titleLabel.font = [UIFont systemFontOfSize:12];
        self.btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [self.btn setTintColor:[UIColor redColor]];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.introduceLabel];
        [self.contentView addSubview:self.img];
        [self.contentView  addSubview:self.listLabel];
        [self.contentView addSubview:self.group];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.btn];
    }
    return self;
}

-(void)creatCell:(AnchorModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.smallLogo]];
    self.nameLabel.text = model.nickname;
    self.introduceLabel.text = model.verifyTitle;
    CGRect frame = self.introduceLabel.frame;
    frame.size.height = [AdjustHeight adjustHeightByString:model.verifyTitle width:170 font:15];
    self.introduceLabel.frame = frame;
    self.img.frame = CGRectMake(90, frame.size.height + 65, 20, 20);
    self.listLabel.frame = CGRectMake(115, frame.size.height + 65, 40, 20);
    self.listLabel.text = [NSString stringWithFormat:@"%@",model.tracksCounts];
    self.group.frame = CGRectMake(170, frame.size.height + 65, 20, 20);
    self.numberLabel.frame = CGRectMake(195, frame.size.height + 65, 60, 20);
    CGFloat f = [model.followersCounts floatValue];
    if (f >= 10000) {
        self.numberLabel.text = [NSString stringWithFormat:@"%.1f万",f/10000];
        
    }else{
        self.numberLabel.text = [NSString stringWithFormat:@"%@",model.followersCounts];
    }
    
}


@end
