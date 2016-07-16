//
//  AllHotTableViewCell.m
//  Product-BB
//
//  Created by 林建 on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AllHotTableViewCell.h"
#define w self.frame.size.width
#define h 120
@implementation AllHotTableViewCell

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
        self.playV = [[UIView alloc]init];
        [self.contentView addSubview:self.playV];
        self.imageV = [[UIImageView alloc]init];
        [self.playV addSubview:self.imageV];
        self.playerV = [[UIImageView alloc]init];
        [self.imageV addSubview:self.playerV];
        self.titleL = [[UILabel alloc]init];
        self.titleL.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.titleL];
        self.authorL = [[UILabel alloc]init];
        self.authorL.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.authorL];
        self.downloadB = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.downloadB setImage:[UIImage imageNamed:@"下载.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.downloadB];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.rankL.frame = CGRectMake(0, 0, w/10, h);
    self.playV.frame = CGRectMake(w/10,h/4,h/2,h/2);
    self.imageV.frame = CGRectMake(0,0,h/2,h/2);
    self.playerV.frame = CGRectMake(0, 0, h/2, h/2);
    CGFloat H = [AdjustHeight adjustHeightByString:self.titleL.text width:w*4/5-h/2-2 font:20];
    self.titleL.frame = CGRectMake(w/10+h/2+10, 10,w*4/5-h/2-2, h/3+H);
    self.authorL.frame = CGRectMake(w/10+h/2+10, h/3+H, w*3/5, h/3-10);
    self.downloadB.frame = CGRectMake(w*9/10-10,h*3/5, w/10, h*2/5-10);
}


-(void)cellConfigureWithModel:(AllHotModel *)model{
    self.rankL.textColor = [UIColor grayColor];
    self.imageV.layer.masksToBounds = YES;
    self.imageV.layer.cornerRadius = h/4;
    self.playerV.image = [UIImage imageNamed:@"7B763FA2005361969C132BF3FA9CC8E5.jpg"];
    self.titleL.numberOfLines = 0;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] completed:nil];
    self.titleL.text = model.title;
    self.authorL.text = [NSString stringWithFormat:@"by %@",model.nickname];
}
@end
