//
//  HistoryOfPlayTableViewCell.h
//  Product-BB
//
//  Created by 林建 on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BroadMusicModel.h"
#import "DingYueModel.h"

@interface HistoryOfPlayTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *intoL;

-(void)cellConfigureWithModel:(BroadMusicModel *)model;

-(void)CellConfigureWithModel:(DingYueModel *)model;
@end
