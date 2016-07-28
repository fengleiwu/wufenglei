//
//  DiscoverCollectView.h
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/12.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverCollectionViewCell.h"
#import "focusImagesModel.h"
@interface DiscoverCollectView : UIView

@property(nonatomic , copy)void(^imageClick)(NSInteger index);


-(instancetype)initWithFrame:(CGRect)frame imageURLs:(NSMutableArray *)arrURLs;


@end
