//
//  CategoryTableViewCell.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryBottomModel.h"

@interface CategoryTableViewCell : UITableViewCell

- (void)cellConfigureWithModel:(CategoryBottomModel *)model;

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIImageView *leftImageV;
@property (nonatomic, strong) UILabel *leftTitleL;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIImageView *rightImageV;
@property (nonatomic, strong) UILabel *rightTitleL;

@end
