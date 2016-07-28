//
//  AnchorCollectionView.h
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/16.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnchorCollectionViewCell.h"
@interface AnchorCollectionView : UIView



@property(nonatomic , copy)void(^imageClick)(NSInteger index);


-(instancetype)initWithFrame:(CGRect)frame imageURLs:(NSMutableArray *)arrURLs;


@end
