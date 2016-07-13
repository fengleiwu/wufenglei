//
//  DiscoverCollectionViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "focusImagesModel.h"
@interface DiscoverCollectionViewCell : UICollectionViewCell


@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UIImageView *littleImageV;

@property(nonatomic , strong)UILabel *label1;
@property(nonatomic , strong)UILabel *label2;

-(void)creatCell:(focusImagesModel *)model;


@end
