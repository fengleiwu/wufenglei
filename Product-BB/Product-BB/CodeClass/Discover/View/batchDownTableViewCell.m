
//
//  batchDownTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "batchDownTableViewCell.h"

@implementation batchDownTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 60, 40)];
        self.titleL.font = [UIFont systemFontOfSize:15];
        self.titleL.numberOfLines = 0;
        self.imageV = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.imageV.frame = CGRectMake(kScreenWidth - 30, 20, 20, 20);
        [self.imageV setImage:[UIImage imageNamed:@"1"] forState:(UIControlStateNormal)];
        [self.imageV setTintColor:[UIColor redColor]];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.imageV];
    }
    return self;
}


-(void)creatCell:(AlbumDetailModel *)model
{
    self.titleL.text = model.title;
    
}



@end
