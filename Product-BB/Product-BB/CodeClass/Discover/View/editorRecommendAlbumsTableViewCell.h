//
//  editorRecommendAlbumsTableViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "focusImagesModel.h"
@interface editorRecommendAlbumsTableViewCell : UITableViewCell

@property(nonatomic , strong)UIImageView *imageV1;
@property(nonatomic , strong)UIImageView *imageV2;
@property(nonatomic , strong)UIImageView *imageV3;
@property(nonatomic , strong)UIImageView *littleImage;
@property(nonatomic , strong)UILabel *nameLabel;
@property(nonatomic , strong)UIButton *more1Btn;
@property(nonatomic , strong)UIButton *more2Btn;
@property(nonatomic , strong)UILabel *label1;
@property(nonatomic , strong)UILabel *label2;
@property(nonatomic , strong)UILabel *label3;
@property(nonatomic , strong)UILabel *littleLabel1;
@property(nonatomic , strong)UILabel *littleLabel2;
@property(nonatomic , strong)UILabel *littleLabel3;

-(void)creatCellWith:(focusImagesModel *)model;


@end
