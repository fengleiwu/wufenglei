//
//  attentionAndFanTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//




#import "attentionAndFanTableViewCell.h"

@implementation attentionAndFanTableViewCell

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
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 80, 80)];
        self.nameL = [[UILabel alloc]initWithFrame:CGRectMake(95, 5, 200, 40)];
        self.voiceL = [[UILabel alloc]initWithFrame:CGRectMake(95, 50, 100, 30)];
        self.fanL = [[UILabel alloc]initWithFrame:CGRectMake(210, 50, 100, 30)];
        [self.contentView addSubview:self.fanL];
        [self.contentView addSubview:self.voiceL];
        [self.contentView addSubview:self.nameL];
        [self.contentView addSubview:self.imageV];
    }
    return self;
}


-(void)creatCell:(attentionFanZanModel *)model
{
    if (model.isVerified == true) {
        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(95, 85, 200, 20)];
        CGFloat width = [AdjustHeight adjustHeightByString:model.nickname hidth:40 font:16];
        self.nameL.width = width;
        self.Vbtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.Vbtn.frame = CGRectMake(95 + width + 5, 5, 20, 20);
        [self.Vbtn setImage:[UIImage imageNamed:@"V"] forState:(UIControlStateNormal)];
        [self.Vbtn setTintColor:[UIColor redColor]];
        [self.contentView addSubview:self.Vbtn];
        [self.contentView addSubview:self.titleL];
    }
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.smallLogo]];
    self.nameL.text = model.nickname;
    
}



@end
