//
//  qualityGoodTableViewCell.h
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/15.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "qualityGoodsModel.h"
@interface qualityGoodTableViewCell : UITableViewCell


@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *bigLabel;
@property(nonatomic , strong)UILabel *middleLabel;
@property(nonatomic , strong)UILabel *smallLabel;
@property(nonatomic , strong)UIButton *btn;


-(void)creatCell:(qualityGoodsModel *)model;

@end
