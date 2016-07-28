//
//  AllHotTableViewCell.h
//  Product-BB
//
//  Created by 林建 on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllHotModel.h"

@interface AllHotTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *rankL;
@property (nonatomic, strong)UIView *playV;
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UIImageView *playerV;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *authorL;
@property (nonatomic, strong)UIButton *downloadB;

-(void)cellConfigureWithModel:(AllHotModel *)model;
@end
