//
//  editorRecommendAlbumsTableViewCell.m
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "editorRecommendAlbumsTableViewCell.h"

@implementation editorRecommendAlbumsTableViewCell

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
        self.more1Btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.more1Btn.frame = CGRectMake(5, 0, kScreenWidth / 2, 20);
        self.more2Btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        
    }
    return self;
}




@end
