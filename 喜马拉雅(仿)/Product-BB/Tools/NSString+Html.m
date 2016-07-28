//
//  NSString+Html.m
//  PKTProject
//
//  Created by young on 15/6/2.
//  Copyright (c) 2015年 young. All rights reserved.
//

#import "NSString+Html.h"

@implementation NSString (Html)

+ (NSString *)importStyleWithHtmlString:(NSString *)HTML
{
    //老的字符串通过HTML这个参数传递过来
    
    //先找到布局文件的路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"style" ofType:@"css"];
    
    //替换HTML字符串中的布局， 修改为通过本地文件配置
    //1.先写一个可用于配置布局的字符串命令，并设置配置类型为本地的文件（命令都是HTML语言， 可以不用懂， 大致知道什么意思就可以了， 文件内容可以让webView中的图片适应屏幕宽度）
    NSString *replace = [NSString stringWithFormat:@"<link href=\"%@\" rel=\"stylesheet\" type=\"text/css\"/>",filePath];
    //2.替换原有的命令字符串
    HTML = [HTML stringByReplacingOccurrencesOfString:@"</head>" withString:replace];
//    NSLog(@"HTML:%@",HTML);
    
    //返回新配置的HTML字符串
    return HTML;

}
@end
