//
//  XMPPManager.m
//  ios11
//
//  Created by 林建 on 16/6/6.
//  Copyright © 2016年 林建. All rights reserved.
//

#import "XMPPManager.h"

@implementation XMPPManager

#pragma mark --- 单例 ---
+(XMPPManager *)shareInstance{
    static XMPPManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XMPPManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        // 初始化对象
        self.stream = [[XMPPStream alloc]init];
        // stream 只有知道以下这两个参数， 才可以进行链接服务端
        // 下面两个设置之后，再链接到自己的服务器，密码账号都是存在在这个服务器里面，服务器的数据存在openfire_mysql.sql  这个文件中
        // 设置服务器IP地址
        self.stream.hostName = kHostName;
        // 设置服务器端口号
        self.stream.hostPort = kHostPort;
        /*
         stream 有三个代理，XMPPManager，注册界面，登录界面
         
         XMPPManager 得知：
         链接服务器成功
         链接服务器失败
         
         注册界面得知：
         注册成功
         注册失败
         
         登录界面得知：
         登录验证成功
         登录验证失败
         */
        [self.stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
    //以下是好友列表需要用到的步骤
        XMPPRosterCoreDataStorage *rosterCoreData = [XMPPRosterCoreDataStorage sharedInstance];
        //获取好友花名册
        self.roster = [[XMPPRoster alloc]initWithRosterStorage:rosterCoreData dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
        //激活好友花名册
        [self.roster activate:self.stream];
        
        //获取好友信息的数据库
        XMPPMessageArchivingCoreDataStorage *messageCoreData = [XMPPMessageArchivingCoreDataStorage sharedInstance];
        self.messageArchiving  =[[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:messageCoreData dispatchQueue:dispatch_get_main_queue()];
        [self.messageArchiving activate:self.stream];
        
        //接收数据管理器 因为 好友聊天界面需要用到这个context进行执行查询请求
        self.context = messageCoreData.mainThreadManagedObjectContext;
    }
    return self;
}

//给controller 提供的注册接口
-(void)registWithUserName:(NSString *)username petName:(NSString *)petName password:(NSString *)password{
    // jid 一个用户身份的标识
    // 这里可以点击kDomin 进入，然后修改域名，域名是服务器的 .lacal 全名
    XMPPJID *jid = [XMPPJID jidWithUser:username domain:kDomin resource:kResource];
   
    // 给stream 进行设置jid， 这里相当于记录的账号
    self.stream.myJID = jid;
    
    //记录密码
    self.password = password;
    self.
    
    // 赋值登录状态 -- 注册
    self.connecType = registType;
    
    // 如果前一个链接用户已经连接完成或者正在连接中，要先断开链接
    // 应用场景：可以注册多个用户
    if (self.stream.isConnected || self.stream.isConnecting) {
        [self.stream disconnect];
    }
    
    // 这行代码才是真正的区链接服务器
    [self.stream connectWithTimeout:10 error:nil];
    // 方法结束，会自动调用xmppStreamDidConnect:判断是否链接服务器成功
}

//给controller 提供的登录接口
-(void)loginWithUserName:(NSString *)username password:(NSString *)password{
    // jid 一个用户身份的标识
    XMPPJID *jid = [XMPPJID jidWithUser:username domain:kDomin resource:kResource];
    
    // 给stream 进行设置jid， 这里相当于记录的账号
    self.stream.myJID = jid;
    
    // 记录密码
    self.password = password;
    // 赋值登录状态 -- 登录
    self.connecType = loginType;
    
    
    // 如果前一个链接用户已经连接完成或者正在连接中，要先断开链接
    // 应用场景：可以注册多个用户
    if (self.stream.isConnected || self.stream.isConnecting) {
        [self.stream disconnect];
    }
    
    // 这行代码才是真正的区链接服务器
    [self.stream connectWithTimeout:10 error:nil];
    // 方法结束，会自动调用xmppStreamDidConnect:判断是否链接服务器成功
}



#pragma mark ------ 链接服务器成功调用的代理方法 -----
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    // 如果是注册，上传用户名和密码
    if (self.connecType == registType) {
        // 存储密码
        [self.stream registerWithPassword:self.password error:nil];
    } else {
        // 如果是登录 验证用户名
        [self.stream authenticateWithPassword:self.password error:nil];
    }
    NSLog(@"服务器链接成功");
}

#pragma mark ------ 链接服务器链接服务器失败/超时调用的代理方法 -----
-(void)xmppStreamConnectDidTimeout:(XMPPStream *)sender{
    NSLog(@"服务器链接失败/超时");
}

@end

