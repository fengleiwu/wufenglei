//
//  AnchorTableViewCell.h
//  Product-BB
//
//  Created by 林建 on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllHotModel.h"
@interface AnchorTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *rankL;
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *intoL;
@property (nonatomic, strong)UIButton *nextB;
@property (nonatomic, strong)UIImageView *dianboV;
@property (nonatomic, strong)UILabel *tracksL;
@property (nonatomic, strong)UIButton *VB;

-(void)cellConfigureWithModel:(AllHotModel *)model;
@end
