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
//
//}

- (void)cellConfigureWithModel:(BroadMusicModel *)model {
    self.titleLabel.text = model.totalTitle;
    
    if (self.isPlay == YES) {
        self.titleLabel.frame = CGRectMake(20,10, self.width-100, 30);
        self.titleLabel.textColor = [UIColor orangeColor];
            [UIView animateWithDuration:3 delay:0 options:
             UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionCurveLinear animations:^{
                 self.titleLabel.transform = CGAffineTransformMakeTranslation(50, 0);
            }completion:nil];

    } else {
        self.titleLabel.frame = CGRectMake(50,10, self.width-100, 30);
    }
}




@end
