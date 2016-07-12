//
//  LocationTableViewCell.m
//  Product-BB
//
//  Created by 林建 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LocationTableViewCell.h"

@implementation LocationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)cellConfigureWithModel:(LocationModel *)model{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverLarge] completed:nil];
    self.titleL.text = model.name;
    self.programL.text = [NSString stringWithFormat:@"直播中：%@",model.programName];
    self.playCountL.text = [NSString stringWithFormat:@"收听人数：%.1lf万",(CGFloat)[model.playCount integerValue]/10000];
}

-(void)CellConfigureWithModel:(RankModel *)model{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverLarge] completed:nil];
    self.titleL.text = model.name;
    self.programL.text = [NSString stringWithFormat:@"直播中：%@",model.programName];
    self.playCountL.text = [NSString stringWithFormat:@"收听人数：%.1lf万",(CGFloat)[model.playCount integerValue]/10000];
}

@end
