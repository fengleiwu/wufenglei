//
//  qualityGoodTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "qualityGoodTableViewCell.h"

@implementation qualityGoodTableViewCell

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
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 100, 100)];
        self.bigLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 5, kScreenWidth - 40 - 115, 40)];
        self.bigLabel.font = [UIFont systemFontOfSize:15];
        self.bigLabel.numberOfLines = 0;
        self.middleLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 55, kScreenWidth - 40 - 115, 20)];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(115, 85, 20, 20)];
        imageV.image = [UIImage imageNamed:@"dot_circle"];
        self.smallLabel = [[UILabel alloc]initWithFrame:CGRectMake(135, 85, kScreenWidth - 40 - 115, 20)];
        self.middleLabel.font = [UIFont systemFontOfSize:12];
        self.smallLabel.font = [UIFont systemFontOfSize:10];
        self.btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btn.frame = CGRectMake(kScreenWidth - 40, 0, 40, 110);
        [self.btn setTitle:@">" forState:(UIControlStateNormal)];
        [self.btn setTintColor:[UIColor grayColor]];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.bigLabel];
        [self.contentView addSubview:self.middleLabel];
        [self.contentView addSubview:self.smallLabel];
        [self.contentView addSubview:imageV];
        [self.contentView addSubview:self.btn];
        
    }
    return self;
}

-(void)creatCell:(qualityGoodsModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverPathSmall]];
    self.bigLabel.text = model.title;
    self.middleLabel.text = model.subtitle;
    self.smallLabel.text = model.footnote;
    
    
}

@end
