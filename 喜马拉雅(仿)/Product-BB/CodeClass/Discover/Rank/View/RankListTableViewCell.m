//
//  RankListTableViewCell.m
//  Product-BB
//
//  Created by 林建 on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RankListTableViewCell.h"

@implementation RankListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)cellConfigureWithModel:(RankListModel *)model{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverPath] completed:nil];
    self.titleL.text = model.title;
    self.titleL1.text = [NSString stringWithFormat:@"1 %@",model.title1];
    self.titleL2.text = [NSString stringWithFormat:@"2 %@",model.title2];
}

-(void)CellConfigureWithModel:(OtherRankListModel *)model{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverPath] completed:nil];
    self.titleL.text = model.title;
    self.titleL1.text = [NSString stringWithFormat:@"1 %@",model.title1];
    self.titleL2.text = [NSString stringWithFormat:@"2 %@",model.title2];
}

@end
