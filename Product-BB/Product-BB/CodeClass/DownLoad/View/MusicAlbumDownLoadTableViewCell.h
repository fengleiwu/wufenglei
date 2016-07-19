//
//  MusicAlbumDownLoadTableViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMusicDownLoadTable.h"
@interface MusicAlbumDownLoadTableViewCell : UITableViewCell


@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *titleL;
@property(nonatomic , strong)UILabel *fuTitleL;
@property(nonatomic , strong)UIButton *btn1;
@property(nonatomic , strong)UILabel *numbelL;
@property(nonatomic , strong)UIButton *btn2;
@property(nonatomic , strong)UILabel *fileL;
@property(nonatomic , strong)UIButton *rubbishBtn;


-(void)creatCell:(NSArray *)arr;


@end
