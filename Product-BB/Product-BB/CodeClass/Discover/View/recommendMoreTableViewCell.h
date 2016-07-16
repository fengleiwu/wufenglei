//
//  recommendMoreTableViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdjustHeight.h"
#import "recommendMoreModel.h"
#import "ListenDetailModel.h"
@interface recommendMoreTableViewCell : UITableViewCell

@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *bigLabel;
@property(nonatomic , strong)UILabel *middleLabel;
@property(nonatomic , strong)UILabel *small1Label;
@property(nonatomic , strong)UILabel *small2Label;
@property(nonatomic , strong)UIImageView *imageV1;
@property(nonatomic , strong)UIImageView *imageV2;
@property(nonatomic , strong)UIButton *btn;


-(void)creatCell:(recommendMoreModel *)model;

-(void)creatListenCell:(ListenDetailModel *)model;//精品听单第一个

@end
