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
        
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//}

- (void)cellConfigureWithModel:(BroadMusicModel *)model {
    self.titleLabel.text = model.totalTitle;
    
    if (model.isPlay == YES) {
        [UIView animateWithDuration:1 animations:^{
            self.titleLabel.frame = CGRectMake(60,10, self.width-60, 30);
        }];
    } else {
        [UIView animateWithDuration:1 animations:^{
            self.titleLabel.frame = CGRectMake(30,10, self.width-60, 30);
        }];
    }
}




@end
