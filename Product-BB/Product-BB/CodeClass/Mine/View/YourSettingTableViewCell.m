//
//  YourSettingTableViewCell.m
//  Product-BB
//
//  Created by 林建 on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "YourSettingTableViewCell.h"

@implementation YourSettingTableViewCell

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
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, (kScreenHeight/10 - kScreenWidth/7)/2, kScreenWidth*4/7, kScreenWidth/7)];
        [self.contentView addSubview:self.label];
        self.nextV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*6/7, (kScreenHeight/10 - kScreenWidth/11)/2, kScreenWidth/11, kScreenWidth/11)];
        self.nextV.image = [UIImage imageNamed:@"箭头 (3).png"];
        [self.contentView addSubview:self.nextV];
        self.timeL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*5/7+10, (kScreenHeight/10 - kScreenWidth/11)/2, kScreenWidth/7, kScreenWidth/11)];
        self.timeL.backgroundColor = [UIColor whiteColor];
        self.timeL.textColor = [UIColor orangeColor];
        [self.contentView addSubview:self.timeL];
    }
    return self;
}

@end
