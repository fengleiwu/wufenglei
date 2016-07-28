//
//  PingLunTableViewCell.m
//  Product-BB
//
//  Created by 林建 on 16/7/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PingLunTableViewCell.h"

@implementation PingLunTableViewCell

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
        self.label = [[UILabel alloc]init];
        self.label.numberOfLines = 0;
        self.label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"对话框实心.png"]];
        [self.contentView addSubview:self.label];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat H = [AdjustHeight adjustHeightByString:self.label.text width:self.label.text.length*20 font:15];
    self.label.frame = CGRectMake(10, 10, self.label.text.length*20, H+10);
    [self.label sizeToFit];
}

@end
