//
//  specialView.m
//  Product-BB
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "specialView.h"
@interface specialView()
@property(nonatomic , strong)NSMutableArray *arr;
@property(nonatomic , strong)UIButton *more1Btn;
@property(nonatomic , strong)UIButton *more2Btn;
@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *bigLabel;
@property(nonatomic , strong)UILabel *middleLabel;
@property(nonatomic , strong)UILabel *littleLabel;
@property(nonatomic , strong)UIButton *btn;
@property(nonatomic , strong)UIImageView *littleImageV;
@property(nonatomic , strong)focusImagesModel *model;
@end

@implementation specialView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame model:(focusImagesModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        [self creatView];
    }
    return self;
}

-(void)creatView
{
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 100, 100)];
    self.bigLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, kScreenWidth - 110 - 40, 40)];
    
    self.middleLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 50, kScreenWidth - 110 - 40, 20)];
    self.middleLabel.font = [UIFont systemFontOfSize:14];
    self.middleLabel.textColor = [UIColor grayColor];
    self.littleImageV = [[UIImageView alloc]initWithFrame:CGRectMake(110, 80, 20, 20)];
    self.littleImageV.image = [UIImage imageNamed:@"dot_circle"];
    self.littleLabel = [[UILabel alloc]initWithFrame:CGRectMake(110 + 25, 80, kScreenWidth - 110 - 40, 20)];
    self.littleLabel.font = [UIFont systemFontOfSize:10];
    self.btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn.frame = CGRectMake(kScreenWidth - 40, 0, 40, 110);
    [self.btn setTitle:@">" forState:(UIControlStateNormal)];
    [self.btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.model.coverPath]];
    self.bigLabel.text = self.model.title;
    self.middleLabel.text = self.model.subtitle;
    self.littleLabel.text = self.model.footnote;
    [self addSubview:self.imageV];
    [self addSubview:self.bigLabel];
    [self addSubview:self.middleLabel];
    [self addSubview:self.littleImageV];
    [self addSubview:self.littleLabel];
    [self addSubview:self.btn];
    
    
}




@end
