//
//  specialTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "specialTableViewCell.h"

@implementation specialTableViewCell

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
        self.bigLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 5, kScreenWidth - 110 - 40, 40)];
        
        self.middleLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 50, kScreenWidth - 110 - 40, 20)];
        self.middleLabel.font = [UIFont systemFontOfSize:14];
        self.middleLabel.textColor = [UIColor grayColor];
        self.littleImageV = [[UIImageView alloc]initWithFrame:CGRectMake(110, 80, 20, 20)];
        self.littleImageV.image = [UIImage imageNamed:@"dot_circle"];
        self.littleLabel = [[UILabel alloc]initWithFrame:CGRectMake(110 + 25, 80, kScreenWidth - 110 - 40, 20)];
        self.littleLabel.font = [UIFont systemFontOfSize:10];
        self.btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btn.frame = CGRectMake(kScreenWidth - 40, 0, 40, 110);
        [self.btn setTitle:@">" forState:(UIControlStateNormal)];
        [self.btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.bigLabel];
        [self.contentView addSubview:self.middleLabel];
        [self.contentView addSubview:self.btn];
        [self.contentView addSubview:self.littleImageV];
        [self.contentView addSubview:self.littleLabel];

    }
    return self;
}

-(void)creatSpecialCell:(focusImagesModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverPath]];
    self.bigLabel.text = model.title;
    self.middleLabel.text = model.subtitle;
    self.littleLabel.text = model.footnote;
}
@end
