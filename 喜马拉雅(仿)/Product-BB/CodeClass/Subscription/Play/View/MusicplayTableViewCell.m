//
//  BroadcastPlayTableViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MusicplayTableViewCell.h"

@interface MusicplayTableViewCell ()


@end

@implementation MusicplayTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleL = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleL];
        
        self.programL = [[UILabel alloc]init];
        [self.contentView addSubview:self.programL];
        
        self.playCountL = [[UILabel alloc]init];
        [self.contentView addSubview:self.playCountL];
        
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageV.frame = CGRectMake(10, 10, 80, 80);
    self.titleL.frame = CGRectMake(100, 10, 200, 30);
    self.titleL.font = [UIFont systemFontOfSize:20];
    self.programL.frame = CGRectMake(100, 60, 200, 30);
    self.programL.textColor = [UIColor lightGrayColor];
    self.playCountL.frame = CGRectMake(self.contentView.frame.size.width - 150, 40, 140, 20);
    self.playCountL.textColor = [UIColor lightGrayColor];
    
//    [self.titleL sizeToFit];
//    
//    // 计算尺寸
//    CGSize size = self.titleL.frame.size;
//    CGFloat oriWidth = 100;
//    if (size.width > oriWidth) {
//        CGFloat offset = size.width - oriWidth;
//        
//        [UIView animateWithDuration:10 delay:0 options:
//         UIViewAnimationOptionRepeat //动画重复的主开关
//         | UIViewAnimationOptionAutoreverse //动画重复自动反向，需要和上面这个一起用
//         | UIViewAnimationOptionCurveLinear //动画的时间曲线，滚动字幕线性比较合理
//                         animations:^{
//                             self.titleL.transform = CGAffineTransformMakeTranslation(-offset, 0);
//                         }completion:nil];
    
//    }
    
   
    
}


-(void)cellConfigureWithModel:(BroadMusicModel *)model{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.bgImage] completed:nil];
    self.titleL.text = model.totalTitle;
    self.programL.text = [NSString stringWithFormat:@"正在直播：%@",model.liveTitle];
    self.playCountL.text = [NSString stringWithFormat:@"%.1lf万人收听过",(CGFloat)[model.playCount integerValue]/10000];

}



@end
