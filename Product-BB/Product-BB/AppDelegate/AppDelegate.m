//
//  AppDelegate.m
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarViewController.h"
#import "EncodeManager.h"
#import "ArrayManager.h"
#import "MyDownLoad.h"
// 后台音频播放
#import <MediaPlayer/MediaPlayer.h>
#import "BroadMusicModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    RootTabBarViewController *root = [[RootTabBarViewController alloc]init];
    self.window.rootViewController = root;
    
    // 设置开机页面
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil]instantiateInitialViewController];
    UIView *vi = viewController.view;
    UIWindow *wi = [UIApplication sharedApplication].delegate.window;
    [wi addSubview:vi];
    [UIView animateWithDuration:3 delay:0 options:(UIViewAnimationOptionBeginFromCurrentState) animations:^{
        vi.alpha = 0.0;
        vi.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0f);
    } completion:^(BOOL finished) {
        [vi removeFromSuperview];
    }];
    
    [ShareSDK registerApp:@"iosv1101"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
                 
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
    
    //从官网注册获取
    //注册短信验证的appKey
    [JSMSSDK registerWithAppKey:@"94426bda4a12dd1fe5221375"];
    
    // 添加通知，接收播放页面信息，用于后台播放。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bgInfo:) name:@"backgroundPlay" object:nil];
    // 后台播放音频
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents]; // 让后台可以处理多媒体的事件
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    return YES;
}

// 后台可以处理多媒体的事件
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
//    NSLog(@"%ld", event.subtype);
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            //点击播放按钮或者耳机线控中间那个按钮
            [[MyPlayerManager defaultManager] play];
            break;
        case UIEventSubtypeRemoteControlPause:
            //点击暂停按钮
            [[MyPlayerManager defaultManager] pause];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            //点击下一曲按钮或者耳机中间按钮两下
            [[NSNotificationCenter defaultCenter] postNotificationName:@"backgroundNext" object:nil];
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            //点击上一曲按钮或者耳机中间按钮三下
            [[NSNotificationCenter defaultCenter] postNotificationName:@"backgroundPrevious" object:nil];
            break;
            
        default:
            break;
    }
}

- (void)bgInfo:(NSNotification *)noti {
    //    CGFloat total = [[MyPlayerManager defaultManager] totalTime];
    //    CGFloat current = [[MyPlayerManager defaultManager] currentTime];
    
    BroadMusicModel *model = noti.object;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    //设置歌曲题目
    [dict setObject:model.totalTitle forKey:MPMediaItemPropertyTitle];
    //设置歌手名
    [dict setObject:model.liveTitle forKey:MPMediaItemPropertyArtist];
    //设置显示的图片
    if (model.isDownload ==YES) {
        UIImage *newImage = [UIImage imageWithData:model.dataImage];
        [dict setObject:[[MPMediaItemArtwork alloc] initWithImage:newImage] forKey:MPMediaItemPropertyArtwork];
        
    }else {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.bgImage]];
        UIImage *newImage = [UIImage imageWithData:data];
        [dict setObject:[[MPMediaItemArtwork alloc] initWithImage:newImage] forKey:MPMediaItemPropertyArtwork];
    }
    
    ////    //设置歌曲时长
    //    [dict setObject:[NSNumber numberWithDouble:300] forKey:MPMediaItemPropertyPlaybackDuration];
    ////    //设置已经播放时长
    //    [dict setObject:[NSNumber numberWithDouble:150] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    
    //更新字典
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
}

- (void)applicationWillResignActive:(UIApplication *)application {//将要进入后台
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    NSString *filePth = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"array.txt" type:CachesType];
//    NSLog(@"%@",filePth);
    NSData *data = [[EncodeManager shareInstance]archiverArray:[ArrayManager shareManager].Array arrayKey:@"array"];
    [data writeToFile:filePth atomically:YES];
    
    
    NSString *file = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"oneArray.tex" type:CachesType];
    NSData *oneData = [[EncodeManager shareInstance]archiverArray:[ArrayManager shareManager].oneArray arrayKey:@"oneArray"];
    [oneData writeToFile:file atomically:YES];
    
//    NSMutableArray *arr = [NSMutableArray array];
//    for (AlbumDetailModel *model in [ArrayManager shareManager].Array) {
//        [arr addObject:model];
//    }
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
//    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"arrManager"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    [[MyDownLoad shareMyDownLoad] stop];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {//已经进入后台
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {//将要进入前台
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    NSString *filePth = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"array.txt" type:CachesType];
//    NSLog(@"%@",filePth);

    [ArrayManager shareManager].Array = [[[EncodeManager shareInstance]unArchiverArrayWithFilePath:filePth arrayKey:@"array"]mutableCopy];
    
    NSString *file = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"oneArray.tex" type:CachesType];
    [ArrayManager shareManager].oneArray = [[[EncodeManager shareInstance]unArchiverArrayWithFilePath:file arrayKey:@"oneArray"]mutableCopy];
    
//    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:@"arrManager"];
//    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    [ArrayManager shareManager].Array = [arr mutableCopy];
//    AlbumDetailModel *model = [ArrayManager shareManager].Array[0];
//    
    
    [[MyDownLoad shareMyDownLoad] start];

}

- (void)applicationDidBecomeActive:(UIApplication *)application {//已经进入前台
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {//将要终止程序
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
