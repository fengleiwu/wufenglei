//
//  CategoryTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CategoryTableViewCell.h"

@implementation CategoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.contentView addSubview:self.leftBtn];
        
        self.leftImageV = [[UIImageView alloc]init];
        [self.leftBtn addSubview:self.leftImageV];
        
        self.leftTitleL = [[UILabel alloc]init];
        [self.leftBtn addSubview:self.leftTitleL];
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = PKCOLOR(245, 245, 245);
        [self.contentView addSubview:self.line];
        
        self.rightBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.contentView addSubview:self.rightBtn];
        
        self.rightImageV = [[UIImageView alloc]init];
        [self.rightBtn addSubview:self.rightImageV];
        
        self.rightTitleL = [[UILabel alloc]init];
        [self.rightBtn addSubview:self.rightTitleL];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    
    self.leftBtn.frame = CGRectMake(0, 0, width / 2 , height);
    self.leftImageV.frame = CGRectMake(width/12, 10, width/17, 20);
    self.leftTitleL.frame = CGRectMake(width/6, 10, width/6, 20);
    
    self.line.frame = CGRectMake(width/2, 8,1, height-16);
    
    self.rightBtn.frame = CGRectMake(width / 2,0 , width / 2, height);
    self.rightImageV.frame = CGRectMake(width/12, 10, width/17, 20);
    self.rightTitleL.frame = CGRectMake(width/6, 10, width/6, 20);
    
    self.leftTitleL.font = [UIFont systemFontOfSize:15];
    [self.leftTitleL sizeToFit];
    self.rightTitleL.font = [UIFont systemFontOfSize:15];
    [self.rightTitleL sizeToFit];
}

- (void)cellConfigureWithModel:(CategoryBottomModel *)model {
//    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverPath]];
//    self.titleL.text = model.title;

    // controller 赋值
}




@end
