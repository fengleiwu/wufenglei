//
//  batchDownTableViewCell.h
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/20.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumDetailModel.h"
@interface batchDownTableViewCell : UITableViewCell


@property(nonatomic , strong)UILabel *titleL;
@property(nonatomic , strong)UIButton *imageV;


-(void)creatCell:(AlbumDetailModel *)model;

@end
