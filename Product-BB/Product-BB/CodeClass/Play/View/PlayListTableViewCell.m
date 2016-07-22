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
        
        self.titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLabel];
        
//        self.activityView = [[MusicActivityView alloc]init];
//        [self.contentView addSubview:self.activityView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isPlay == YES) {
        self.titleLabel.frame = CGRectMake(100,10, self.width-100, 30);
    } else {
        self.titleLabel.frame = CGRectMake(10,10, self.width-10, 30);
    }
//    self.titleLabel.frame = CGRectMake(10,10, self.width-10, 30);
}

- (void)cellConfigureWithModel:(BroadMusicModel *)model {
    self.titleLabel.text = model.totalTitle;
    
}




@end
