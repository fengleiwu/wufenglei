//
//  ContentTableViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumDetailModel.h"
#import "AdjustHeight.h"
#import "DetailPayModel.h"
@interface ContentTableViewCell : UITableViewCell

@property (nonatomic , strong)UILabel *contentTextView;
@property (nonatomic , strong)UILabel *contentLabel;
@property(nonatomic , strong)UIButton *moreBtn;



-(void)creatCell:(NSString *)url;

-(void)creatPayCell:(DetailPayModel *)model;


@end
