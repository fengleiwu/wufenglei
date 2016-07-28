//
//  AllMoreTableViewCell.m
//  Product-BB
//
//  Created by 林建 on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AllMoreTableViewCell.h"
#define w self.frame.size.width
#define h self.frame.size.height

@implementation AllMoreTableViewCell

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
        self.titleL.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.titleL];
        
        self.intoL = [[UILabel alloc]init];
        self.intoL.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.intoL];
        
        self.nextB = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.nextB setImage:[UIImage imageNamed:@"箭头 (3).png"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.nextB];
        
        self.dianboV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.dianboV];
        self.tracksL = [[UILabel alloc]init];
        [self.contentView addSubview:self.tracksL];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.rankL.frame = CGRectMake(0, 0, 30, h);
    self.imageV.frame = CGRectMake(30,h/10,h*4/5,h*4/5);
    
    CGFloat titleWidth = w-h*4/5-40-30;
    CGFloat titleX = 40+h*4/5;
    self.titleL.frame = CGRectMake(titleX, 10,titleWidth, 30);
    self.intoL.frame = CGRectMake(titleX, 50, titleWidth, 20);
    
    self.dianboV.frame = CGRectMake(titleX, 80, 20, 20);
    self.tracksL.frame = CGRectMake(titleX+30, 80, 60, 20);
    
    self.nextB.frame = CGRectMake(w-30,h/2-10, 20, 20);

}


-(void)cellConfigureWithModel:(AllHotModel *)model{
    self.rankL.textColor = [UIColor grayColor];
    self.titleL.numberOfLines = 0;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] completed:nil];
    self.titleL.text = model.title;
    self.intoL.text = [NSString stringWithFormat:@"%@",model.intro];
    self.dianboV.image = [UIImage imageNamed:@"电波-01.png"];
    self.tracksL.text = [NSString stringWithFormat:@"%ld集",[model.tracks integerValue]];
    self.tracksL.font = [UIFont systemFontOfSize:13];
    self.tracksL.textColor = [UIColor grayColor];
}

@end
