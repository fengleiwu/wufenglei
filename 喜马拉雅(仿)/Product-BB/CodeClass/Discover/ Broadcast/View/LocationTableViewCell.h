//
//  LocationTableViewCell.h
//  Product-BB
//
//  Created by 林建 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationModel.h"
#import "RankModel.h"
#import "BroadListModel.h"
@interface LocationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *programL;
@property (weak, nonatomic) IBOutlet UILabel *playCountL;
@property (weak, nonatomic) IBOutlet UIButton *playB;

-(void)cellConfigureWithModel:(LocationModel *)model;

-(void)CellConfigureWithModel:(RankModel *)model;

- (void)CellConfigureWithBroadListModel:(BroadListModel *)model;

@end
