//
//  MBProgressHUD+GifHUD.h
//  DouBanProject
//
//  Created by lanou3g on 16/5/10.
//  Copyright © 2016年 ccl. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (GifHUD)
/**
 *  加载gif动画
 *
 *  @param frame   HUD视图的大小
 *  @param gifName gif图片的名字
 *  @param view    HUD添加显示所在的View
 */
+(void)setUpHUDWithFrame:(CGRect)frame gifName:(NSString * )gifName andShowToView:(UIView *)view;
@end
