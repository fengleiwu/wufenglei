//
//  DetailListTableViewCell.h
//  Product-BB
//
//  Created by 林建 on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableListModel.h"
#import "SUBModel.h"
@interface DetailListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *infoL;
@property (weak, nonatomic) IBOutlet UILabel *playCountL;
@property (weak, nonatomic) IBOutlet UILabel *TVCountL;

-(void)cellConfigureWithModel:(TableListModel *)model;
-(void)CellConfigureWithModel:(SUBModel *)model;
@end
