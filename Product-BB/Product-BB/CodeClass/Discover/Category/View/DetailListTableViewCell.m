//
//  DetailListTableViewCell.m
//  Product-BB
//
//  Created by 林建 on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DetailListTableViewCell.h"

@implementation DetailListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)cellConfigureWithModel:(TableListModel *)model{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverLarge] completed:nil];
    self.titleL.text = model.title;
    self.infoL.text = model.intro;
    self.playCountL.text = [NSString stringWithFormat:@"%.1f万",(CGFloat)[model.playsCounts integerValue]/10000];
    self.TVCountL.text = [NSString stringWithFormat:@"%ld集",[model.tracks integerValue]];
}

-(void)CellConfigureWithModel:(SUBModel *)model{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverLarge] completed:nil];
    self.titleL.text = model.title;
    self.infoL.text = model.recReason;
    self.playCountL.text = [NSString stringWithFormat:@"%.1f万",(CGFloat)[model.playsCounts integerValue]/10000];
    self.TVCountL.text = [NSString stringWithFormat:@"%ld集",[model.tracks integerValue]];
}
@end
