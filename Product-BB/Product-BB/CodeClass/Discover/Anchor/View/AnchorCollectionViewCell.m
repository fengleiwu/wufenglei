//
//  AnchorCollectionViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AnchorCollectionViewCell.h"

@implementation AnchorCollectionViewCell




-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width + 45)];
        
        
        self.imageV.layer.shadowOpacity = 0.5;
        self.imageV.layer.shadowColor = [UIColor grayColor].CGColor;
        self.imageV.layer.shadowRadius = 3;
        self.imageV.layer.shadowOffset = CGSizeMake(2, 2);
        [self.imageV.layer setBorderWidth:1];
        [self.imageV.layer setBorderColor:[UIColor grayColor].CGColor];
        
        self.imageV.backgroundColor = [UIColor whiteColor];
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.width, self.frame.size.width, 40)];
        self.label1.font = [UIFont systemFontOfSize:14];
        self.label1.numberOfLines = 0;
        self.label1.textAlignment = NSTextAlignmentCenter;
        self.littleImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0 , self.frame.size.width, self.frame.size.width)];
        [self.imageV addSubview:self.label1];
        [self.imageV addSubview:self.littleImageV];
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.width + 45 + 10, self.frame.size.width, 40)];
        self.label2.font = [UIFont systemFontOfSize:12];
        self.label2.numberOfLines = 0;
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.label2];
    }
    return self;
}



-(void)creatCell:(AnchorModel *)model
{
    [self.littleImageV sd_setImageWithURL:[NSURL URLWithString:model.middleLogo]];
    self.label1.text = model.nickname;
    self.label2.text = model.verifyTitle;
}



@end
