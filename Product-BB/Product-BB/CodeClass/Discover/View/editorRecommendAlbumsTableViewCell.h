//
//  editorRecommendAlbumsTableViewCell.h
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "focusImagesModel.h"
#import "DiscoverCollectView.h"
@interface editorRecommendAlbumsTableViewCell : UITableViewCell


@property(nonatomic , strong)UIButton *more1Btn;
@property(nonatomic , strong)UIButton *more2Btn;
@property(nonatomic , strong)DiscoverCollectView *disc;


-(void)creatCell:(NSMutableArray *)arr;



@end
