//
//  AnchorSongerTableViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnchorModel.h"

@interface AnchorSongerTableViewCell : UITableViewCell

@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *nameLabel;
@property(nonatomic , strong)UILabel *introduceLabel;
@property(nonatomic , strong)UILabel *listLabel;
@property(nonatomic , strong)UILabel *numberLabel;
@property(nonatomic , strong)UIButton *btn;
@property(nonatomic , strong)UIImageView *img;
@property(nonatomic , strong)UIImageView *group;


-(void)creatCell:(AnchorModel *)model;


@end
