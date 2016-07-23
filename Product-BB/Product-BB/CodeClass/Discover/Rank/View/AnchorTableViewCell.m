//
//  AnchorTableViewCell.m
//  Product-BB
//
//  Created by 林建 on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AnchorTableViewCell.h"
#define w self.frame.size.width
#define h 120

@implementation AnchorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.rankL = [[UILabel alloc]init];
        self.rankL.textAlignment = NSTextAlignmentCenter;
        self.rankL.font = [UIFont systemFontOfSize:22];
        [self.contentView addSubview:self.rankL];
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
        self.titleL = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleL];
        self.intoL = [[UILabel alloc]init];
        self.intoL.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.intoL];
        self.nextB = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.nextB setImage:[UIImage imageNamed:@"箭头 (3).png"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.nextB];
        self.VB = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.VB setImage:[UIImage imageNamed:@"V.png"] forState:UIControlStateNormal];
        self.VB.tintColor = [UIColor orangeColor];
        [self.contentView addSubview:self.VB];
        self.dianboV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.dianboV];
        self.tracksL = [[UILabel alloc]init];
        [self.contentView addSubview:self.tracksL];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.rankL.frame = CGRectMake(0, 0, w/10, h);
    self.imageV.frame = CGRectMake(w/10,h/6-10,h*2/3,h*2/3);
    self.titleL.frame = CGRectMake(w/10+h*2/3+10, 10,w*4/5-h/2-2, h/3);
    self.titleL.font = [UIFont systemFontOfSize:20];//label自适应宽度
    [self.titleL sizeToFit];
    self.VB.frame = CGRectMake(self.titleL.frame.size.width+w/10+h*2/3+10, 10, 20, h/6);
    self.intoL.frame = CGRectMake(w/10+h*2/3+10, h/3, w*3/5-20, h/3-10);
    self.nextB.frame = CGRectMake(w*9/10-10,h*2/5, w/10, h*2/5-10);
    self.dianboV.frame = CGRectMake(w/10+h*2/3+10, h*2/3, 20, h/6);
    self.tracksL.frame = CGRectMake(w/10+h*2/3+40, h*2/3, 60, h/6);
}


-(void)cellConfigureWithModel:(AllHotModel *)model{
    self.rankL.textColor = [UIColor grayColor];
    self.titleL.numberOfLines = 0;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.largeLogo] completed:nil];
    self.titleL.text = model.nickname;
    self.intoL.text = [NSString stringWithFormat:@"%@",model.personDescribe];
    self.dianboV.image = [UIImage imageNamed:@"人气.png"];
    if ([model.followersCounts  integerValue]< 10000) {
        self.tracksL.text = [NSString stringWithFormat:@"%ld",[model.followersCounts integerValue]];
    } else {
        self.tracksL.text = [NSString stringWithFormat:@"%.lf万",(CGFloat)[model.followersCounts integerValue]/10000];
    }
    self.tracksL.font = [UIFont systemFontOfSize:13];
    self.tracksL.textColor = [UIColor grayColor];
}

@end
