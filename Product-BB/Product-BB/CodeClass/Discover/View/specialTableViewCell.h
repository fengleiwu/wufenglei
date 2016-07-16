//
//  specialTableViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "focusImagesModel.h"
@interface specialTableViewCell : UITableViewCell


@property(nonatomic , strong)NSMutableArray *arr;
@property(nonatomic , strong)UIButton *more1Btn;
@property(nonatomic , strong)UIButton *more2Btn;
@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *bigLabel;
@property(nonatomic , strong)UILabel *middleLabel;
@property(nonatomic , strong)UILabel *littleLabel;
@property(nonatomic , strong)UIButton *btn;
@property(nonatomic , strong)UIImageView *littleImageV;


-(void)creatSpecialCell:(focusImagesModel *)model;



@end
