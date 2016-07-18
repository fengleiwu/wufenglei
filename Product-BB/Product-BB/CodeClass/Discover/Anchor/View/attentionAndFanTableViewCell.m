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
        self.nameL = [[UILabel alloc]initWithFrame:CGRectMake(90, 5, 200, 40)];
        self.nameL.font = [UIFont systemFontOfSize:16];
        self.voiceL = [[UILabel alloc]initWithFrame:CGRectMake(90, 45, 100, 30)];
        self.voiceL.textColor = [UIColor grayColor];
        self.voiceL.font = [UIFont systemFontOfSize:12];
        self.fanL = [[UILabel alloc]initWithFrame:CGRectMake(210, 45, 100, 30)];
        self.fanL.textColor = [UIColor grayColor];
        self.fanL.font = [UIFont systemFontOfSize:12];
        self.titleL = [[UILabel alloc]init];
        self.titleL.font = [UIFont systemFontOfSize:14];
        self.titleL.numberOfLines = 0;
        self.Vbtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.contentView addSubview:self.fanL];
        [self.contentView addSubview:self.voiceL];
        [self.contentView addSubview:self.nameL];
        [self.contentView addSubview:self.imageV];
            }
    return self;
}


-(void)creatguanzhuCell:(attentionFanZanModel *)model
{
    CGFloat width = [AdjustHeight adjustHeightByString:model.nickname hidth:40 font:14];
    self.nameL.width = width + 20;
    self.nameL.text = model.nickname;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.smallLogo]];
    self.voiceL.text = [NSString stringWithFormat:@"声音%@",model.tracks];
    CGFloat number = [model.followers floatValue];
    if (number > 10000) {
        self.fanL.text = [NSString stringWithFormat:@"粉丝:%.1f万",number / 10000];
    }else{
        self.fanL.text = [NSString stringWithFormat:@"粉丝%@",model.followers];
    }
    
    if (model.isVerified == true) {
        self.titleL.frame = CGRectMake(95, 80, 200, 40);
        self.titleL.text = model.ptitle;
        self.titleL.textColor = [UIColor redColor];
        
        self.Vbtn.frame = CGRectMake(95 + width + 10, 15, 20, 20);
        [self.Vbtn setImage:[UIImage imageNamed:@"V"] forState:(UIControlStateNormal)];
        [self.Vbtn setTintColor:[UIColor redColor]];
        [self.contentView addSubview:self.Vbtn];
        [self.contentView addSubview:self.titleL];

    }else{
        [self.Vbtn removeFromSuperview];
        [self.titleL removeFromSuperview];
    }
}


@end
