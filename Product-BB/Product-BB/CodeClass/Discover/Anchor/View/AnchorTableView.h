//
//  AnchorTableView.h
//  Product-BB
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnchorTableViewCell.h"
#import "AnchorModel.h"
@interface AnchorTableView : UIView

@property(nonatomic , strong)UITableView *table;
@property(nonatomic , strong)NSMutableArray *famousArr;
@property(nonatomic , strong)NSMutableArray *famousTitle;
@property(nonatomic , strong)NSMutableArray *songerArray;
@property(nonatomic , strong)NSMutableArray *normalArray;
@property(nonatomic , strong)NSMutableArray *normaleTitleArray;




-(instancetype)initWithFrame:(CGRect)frame;

@end
