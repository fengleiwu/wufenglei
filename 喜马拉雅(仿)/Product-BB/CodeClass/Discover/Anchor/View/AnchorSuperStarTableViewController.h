//
//  AnchorSuperStarTableViewController.h
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/16.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnchorSuperStarTableViewController : UITableViewController

@property(nonatomic , strong)NSString *titleL;
@property(nonatomic , strong)NSString *MyID;//famous

@property(nonatomic , strong)NSString *name;//有最新和最热 normal

@property(nonatomic , assign)NSInteger inter;//判断哪个传的 1是famous 2是normal


@end
