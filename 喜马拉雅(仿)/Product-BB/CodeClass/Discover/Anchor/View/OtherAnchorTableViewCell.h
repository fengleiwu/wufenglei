//
//  OtherAnchorTableViewCell.h
//  Product-BB
//
//  Created by 林建 on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnchorCollectionView.h"
@interface OtherAnchorTableViewCell : UITableViewCell

@property(nonatomic , strong)UIButton *more1Btn;
@property(nonatomic , strong)UIButton *more2Btn;
@property(nonatomic , strong)AnchorCollectionView *disc;

-(void)creatCell:(NSMutableArray *)arr;

@end
