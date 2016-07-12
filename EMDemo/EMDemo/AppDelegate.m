//
//  AppDelegate.m
//  EMDemo
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AppDelegate.h"
#import <EMSDK.h>
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"twx253#abc123qaz"];
    options.apnsCertName = @"istore_dev";//com.lanou.EMDome6hao
    [[EMClient sharedClient] initializeSDKWithOptions:options];
 
    LoginViewController *loginVC = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LoginViewController class])];
    UINavigationController *naVC =(UINavigationController *)self.window.rootViewController;
    [naVC pushViewController:loginVC animated:NO];
    
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
//APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
//APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
    [[EMClient sharedClient] applicationWillEnterForeground:application];

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
