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
        self.titleL.frame = CGRectMake(100, self.height/10, self.width - 110, 30);
        self.titleL.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.titleL];
        
        self.programL = [[UILabel alloc]init];
        self.programL.frame = CGRectMake(100, self.height/10+30+30, self.width - 110, 20);
        self.programL.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.programL];
        
        self.playCountL = [[UILabel alloc]init];
        self.playCountL.frame = CGRectMake(self.contentView.frame.size.width - 150, self.height/10+30+5, 140, 20);
        self.playCountL.textAlignment = NSTextAlignmentRight;
        self.playCountL.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.playCountL];
        
        self.imageV = [[UIImageView alloc]init];
         self.imageV.frame = CGRectMake(10, self.height/10, 80, 80);
        [self.contentView addSubview:self.imageV];
    }
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//}

-(void)cellConfigureWithModel:(BroadMusicModel *)model{
    if (model.isDownload == YES) {
        self.imageV.image = [UIImage imageWithData:model.dataImage];
    }else {
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.bgImage] completed:nil];
    }
    
    self.titleL.text = model.totalTitle;
    self.programL.text = [NSString stringWithFormat:@"正在直播：%@",model.liveTitle];
    self.playCountL.text = [NSString stringWithFormat:@"%.1lf万人收听过",(CGFloat)[model.playCount integerValue]/10000];
}

@end
