//
//  attentionAndFanTableViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "attentionFanZanModel.h"
@interface attentionAndFanTableViewCell : UITableViewCell

@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *nameL;
@property(nonatomic , strong)UILabel *voiceL;
@property(nonatomic , strong)UILabel *fanL;
@property(nonatomic , strong)UILabel *titleL;
@property(nonatomic , strong)UIButton *Vbtn;


-(void)creatguanzhuCell:(attentionFanZanModel *)model;



@end
