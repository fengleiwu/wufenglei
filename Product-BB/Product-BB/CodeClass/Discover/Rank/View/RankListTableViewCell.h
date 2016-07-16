//
//  RankListTableViewCell.h
//  Product-BB
//
//  Created by 林建 on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankListModel.h"
#import "OtherRankListModel.h"

@interface RankListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *titleL1;
@property (weak, nonatomic) IBOutlet UILabel *titleL2;

-(void)cellConfigureWithModel:(RankListModel *)model;

-(void)CellConfigureWithModel:(OtherRankListModel *)model;
@end
