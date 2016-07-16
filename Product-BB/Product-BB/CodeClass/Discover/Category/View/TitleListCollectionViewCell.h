//
//  TitleListCollectionViewCell.h
//  Product-BB
//
//  Created by 林建 on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CateTypeModel.h"
#import "HotTitleModel.h"
@interface TitleListCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)UILabel *label;

-(void)cellConfigureWithModel:(CateTypeModel *)model;

-(void)CellConfigureWithModel:(HotTitleModel *)model;
@end
