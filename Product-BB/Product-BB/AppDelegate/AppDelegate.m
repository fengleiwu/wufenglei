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
    
    //从官网注册获取
    //注册短信验证的appKey
    [JSMSSDK registerWithAppKey:@"188a49f330fb6d0245d74f18"];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {//将要进入后台
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    NSString *filePth = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"array.txt" type:CachesType];

    NSData *data = [[EncodeManager shareInstance]archiverArray:[ArrayManager shareManager].Array arrayKey:@"array"];
    [data writeToFile:filePth atomically:YES];
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {//已经进入后台
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {//将要进入前台
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    NSString *filePth = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"array.txt" type:CachesType];
    [ArrayManager shareManager].Array = [[[EncodeManager shareInstance]unArchiverArrayWithFilePath:filePth arrayKey:@"array"]mutableCopy];
   
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {//已经进入前台
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {//将要终止程序
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
