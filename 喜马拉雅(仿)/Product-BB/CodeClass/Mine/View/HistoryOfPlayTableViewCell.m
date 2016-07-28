//
//  HistoryOfPlayTableViewCell.m
//  Product-BB
//
//  Created by 林建 on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HistoryOfPlayTableViewCell.h"
#define w self.frame.size.width
#define h self.frame.size.height

@implementation HistoryOfPlayTableViewCell

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
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
        self.titleL = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleL];
        self.intoL = [[UILabel alloc]init];
        [self.contentView addSubview:self.intoL];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(5,(h-w/5)/2,w/5,w/5);
    self.titleL.frame = CGRectMake(w/5+10, (h-w/5)/2,w*4/5-5,h*2/3 - (h-w/5)/2);
    self.intoL.frame = CGRectMake(w/5+10, h*2/3, w*4/5-5, (h-w/5)/2);
}


-(void)cellConfigureWithModel:(BroadMusicModel *)model{
    self.titleL.numberOfLines = 0;
    self.titleL.font = [UIFont systemFontOfSize:17];
    UIImage *image = [UIImage imageNamed:@"1004.jpg"];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.bgImage] placeholderImage:image completed:nil];
    self.titleL.text = model.totalTitle;
    self.intoL.text = model.liveTitle;
    self.intoL.textColor = [UIColor grayColor];
    self.intoL.font = [UIFont systemFontOfSize:15];
}

-(void)CellConfigureWithModel:(DingYueModel *)model{
    self.titleL.numberOfLines = 0;
    self.titleL.font = [UIFont systemFontOfSize:17];
    UIImage *image = [UIImage imageNamed:@"1004.jpg"];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:image completed:nil];
    self.titleL.text = model.bigTitle;
    self.intoL.text = model.smallTitle;
    self.intoL.textColor = [UIColor grayColor];
    self.intoL.font = [UIFont systemFontOfSize:15];
}

@end
