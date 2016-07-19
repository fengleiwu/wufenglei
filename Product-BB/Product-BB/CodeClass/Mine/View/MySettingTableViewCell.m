//
//  MySettingTableViewCell.m
//  Product-BB
//
//  Created by 林建 on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MySettingTableViewCell.h"

@implementation MySettingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageB = [UIButton buttonWithType:UIButtonTypeSystem];
        self.imageB.frame = CGRectMake(10, (kScreenHeight/10 - kScreenWidth/11)/2, kScreenWidth/11, kScreenWidth/11);
        [self.contentView addSubview:self.imageB];
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(10+kScreenWidth/7, (kScreenHeight/10 - kScreenWidth/7)/2, kScreenWidth*4/7, kScreenWidth/7)];
        [self.contentView addSubview:self.label];
        self.nextV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*6/7, (kScreenHeight/10 - kScreenWidth/11)/2, kScreenWidth/11, kScreenWidth/11)];
        [self.contentView addSubview:self.nextV];
    }
    return self;
}


@end
