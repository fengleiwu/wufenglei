//
//  XMPPManager.h
//  ios11
//
//  Created by 林建 on 16/6/6.
//  Copyright © 2016年 林建. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, ConnectType){
    registType,
    loginType
};

@interface XMPPManager : NSObject<XMPPStreamDelegate>

/*
 该类的作用：
 1、第一次初始化该类的时候，配置好客户端和服务端一些必备的参数
 2、初始化XMPP第三方的类的对象
 3、留一些接口提供给controller进行使用
 */
#pragma mark --- 单例 ---
+(XMPPManager *)shareInstance;

#pragma mark ----- 注册和登录用到的属性和接口 ----
// 用于链接客户端和服务端的通讯管道，相当于是一根电话线
@property (nonatomic, strong)XMPPStream *stream;

// 记录密码， 在链接服务器成功的代理方法中需要用到
@property (nonatomic, strong)NSString *password;
@property (nonatomic, strong)NSString *petName;
// 枚举的属性，用于记录链接状态
@property (nonatomic, assign)ConnectType connecType;

#pragma mark --- 好友列表需要用到的属性 ---
//好友花名册
//XMPPRoster需要从XMPPRosterCoreDataStorage这个类中获取
//然后需要将花名册在服务器上激活
@property (nonatomic, strong)XMPPRoster *roster;

#pragma mark --- 聊天信息需要用到的属性 ---
@property (nonatomic, strong)XMPPMessageArchiving *messageArchiving;

@property (nonatomic, strong)NSManagedObjectContext *context;
//@property (nonatomic, strong)NSString *

//给controller 提供的注册接口
-(void)registWithUserName:(NSString *)username petName:(NSString *)petName password:(NSString *)password;

//给controller 提供的登录接口
-(void)loginWithUserName:(NSString *)username password:(NSString *)password;

@end
