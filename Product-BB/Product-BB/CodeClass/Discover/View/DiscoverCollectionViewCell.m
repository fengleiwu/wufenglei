//
//  DiscoverCollectionViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiscoverCollectionViewCell.h"

@implementation DiscoverCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.width + 10, self.frame.size.width, 40)];
        self.label1.font = [UIFont systemFontOfSize:14];
        self.label1.numberOfLines = 0;
        self.littleImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.width + 10 + 40 + 5 , 20, 20)];
        self.littleImageV.image = [UIImage imageNamed:@"dot_circle"];
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(25, self.frame.size.width + 10 + 40 + 5, self.frame.size.width - 25, 20)];
        self.label2.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.label2];
        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.littleImageV];
    }
    return self;
}

-(void)creatCell:(focusImagesModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverMiddle]];
    self.label1.text = model.intro;
    self.label2.text = model.title;
}

@end
