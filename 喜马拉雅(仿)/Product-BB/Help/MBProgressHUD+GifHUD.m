//
//  MBProgressHUD+GifHUD.m
//  DouBanProject
//
//  Created by lanou3g on 16/5/10.
//  Copyright © 2016年 ccl. All rights reserved.
//

#import "MBProgressHUD+GifHUD.h"
#import <SDWebImage/UIImage+GIF.h>
#import "Color_Marco.h"
@implementation MBProgressHUD (GifHUD)
+(void)setUpHUDWithFrame:(CGRect)frame gifName:(NSString *)gifName andShowToView:(UIView *)view {
    
    
    
    
    UIImage *img = [UIImage sd_animatedGIFNamed:gifName];
    UIImageView *gifView = [[UIImageView alloc] initWithFrame:frame];
    gifView.image = img;
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    
    hud.color = WH_COLOR(0, 0, 0, 0.2);
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"正在加载";
    hud.customView = gifView;
    
    
}
@end
