//
//  AnchorTableViewController.h
//  Product-BB
//
//  Created by 吴峰磊 on 16/7/16.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnchorTableViewController : UIViewController

@property(nonatomic , strong)UITableView *table;

+(AnchorTableViewController *)shareManager;

-(void)creatTableView:(CGRect)frame;


@end
