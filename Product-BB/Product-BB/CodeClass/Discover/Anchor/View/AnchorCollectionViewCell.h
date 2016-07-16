//
//  AnchorCollectionViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnchorModel.h"
#import <QuartzCore/QuartzCore.h>
@interface AnchorCollectionViewCell : UICollectionViewCell

@property(nonatomic , strong)UIView *imageV;
@property(nonatomic , strong)UIImageView *littleImageV;

@property(nonatomic , strong)UILabel *label1;
@property(nonatomic , strong)UILabel *label2;


-(void)creatCell:(AnchorModel *)model;


@end
