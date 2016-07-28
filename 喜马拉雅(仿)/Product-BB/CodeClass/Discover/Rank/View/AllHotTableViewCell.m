//
//  AllHotTableViewCell.m
//  Product-BB
//
//  Created by 林建 on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AllHotTableViewCell.h"
#define w self.frame.size.width
#define h self.frame.size.height
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
        self.rankL.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.rankL];
        
        self.playV = [[UIView alloc]init];
        [self.contentView addSubview:self.playV];
        
        self.imageV = [[UIImageView alloc]init];
        [self.playV addSubview:self.imageV];
        
        self.playerV = [[UIImageView alloc]init];
        [self.playV addSubview:self.playerV];
        
        self.titleL = [[UILabel alloc]init];
        self.titleL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:self.titleL];
        
        self.authorL = [[UILabel alloc]init];
        self.authorL.textColor = [UIColor grayColor];
        self.authorL.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.authorL];
        
        self.downloadB = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.downloadB setImage:[UIImage imageNamed:@"下载.jpg"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.downloadB];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.rankL.frame = CGRectMake(0, 0, 30, h);
    CGFloat playVWidth = w/10;
    self.playV.frame = CGRectMake(30,h/2-playVWidth/2,playVWidth,playVWidth);
    self.imageV.frame = CGRectMake(0,0,playVWidth,playVWidth);
    self.playerV.frame = CGRectMake(0,0, playVWidth, playVWidth);
    
    self.imageV.layer.masksToBounds = YES;
    self.imageV.layer.cornerRadius = playVWidth/2;

    self.titleL.numberOfLines = 0;
    CGFloat titleWidth =w*9/10-40-40;
    CGFloat H = [AdjustHeight adjustHeightByString:self.titleL.text width:titleWidth font:18];
    self.titleL.frame = CGRectMake(w/10+40,10,titleWidth, H);
    
    self.authorL.frame = CGRectMake(w*2/10+5, CGRectGetMaxY(self.titleL.frame)+10, w*6/10, 20);
    self.downloadB.frame = CGRectMake(w-30,h/2-10, 20, 20);
}


-(void)cellConfigureWithModel:(AllHotModel *)model{
    self.rankL.textColor = [UIColor grayColor];
    self.playerV.image = [UIImage imageNamed:@"7B763FA2005361969C132BF3FA9CC8E5.jpg"];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] completed:nil];
    self.titleL.text = model.title;
    self.authorL.text = [NSString stringWithFormat:@"by %@",model.nickname];
}
@end
