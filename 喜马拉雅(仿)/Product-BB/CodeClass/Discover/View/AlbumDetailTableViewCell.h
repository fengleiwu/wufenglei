//
//  AlbumDetailTableViewCell.h
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/13.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicActivityView.h"
#import "AlbumDetailModel.h"
@interface AlbumDetailTableViewCell : UITableViewCell


@property(nonatomic , strong)UIImageView *imageV;
//@property(nonatomic , strong)MusicActivityView *activityView;
@property(nonatomic , strong)UILabel *bigLabel;
@property(nonatomic , strong)UIImageView *littleImageV1;
@property(nonatomic , strong)UIImageView *littleImageV2;
@property(nonatomic , strong)UILabel *littleLabel1;
@property(nonatomic , strong)UILabel *littleLabel2;
@property(nonatomic , strong)UILabel *playLabel;
@property(nonatomic , strong)UIButton *downLoadBtn;

-(void)creatCell:(AlbumDetailModel *)model;


@end
