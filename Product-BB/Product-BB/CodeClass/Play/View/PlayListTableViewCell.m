//
//  PlayListTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PlayListTableViewCell.h"

@implementation PlayListTableViewCell

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
//        self.playImageV = [[UIImageView alloc]init];
//        [self.contentView addSubview:self.playImageV];
//        self.downloadImageV = [[UIImageView alloc]init];
//        [self.contentView addSubview:self.downloadImageV];
        
        self.activityView = [[MusicActivityView alloc]init];
        self.activityView.frame = CGRectMake(10, 10, 20, 20);
        self.activityView.defaultSize = self.activityView.frame.size;
        self.activityView.numberOfRect = 4;
            self.activityView.rectBackgroundColor = [UIColor orangeColor];
        self.activityView.space = 2;
        [self.contentView addSubview:self.activityView];
        [self.activityView stopAnimation];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isPlay == YES) {
//        [UIView animateWithDuration:2 animations:^{
            self.titleLabel.frame = CGRectMake(30,10, self.width-50, 30);
//            self.activityView.frame = CGRectMake(0, 10, 30, 30);
//            self.activityView.defaultSize = self.activityView.frame.size;
//        }];
//        [self.activityView startAnimation];
//        self.activityView.alpha = 1;
    } else {
//        [UIView animateWithDuration:2 animations:^{
            self.titleLabel.frame = CGRectMake(10,10, self.width-50, 30);
//            self.activityView.frame = CGRectMake(0, 10, 0, 30);
//            self.activityView.defaultSize = self.activityView.frame.size;
//        }];
//        [self.activityView stopAnimation];
//        self.activityView.alpha = 0;
    }
    
}

- (void)cellConfigureWithModel:(BroadMusicModel *)model {
    self.titleLabel.text = model.totalTitle;
    
}




@end
