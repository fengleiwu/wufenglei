//
//  TitleListCollectionViewCell.m
//  Product-BB
//
//  Created by 林建 on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TitleListCollectionViewCell.h"

@implementation TitleListCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 25)];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
    }
    return self;
}

-(void)cellConfigureWithModel:(CateTypeModel *)model{
    self.label.text = model.keywordName;
//    self.label.frame = CGRectMake(0, 0, model.tname.length *20, 35);
}

-(void)CellConfigureWithModel:(HotTitleModel *)model{
    self.label.text = model.name;
}
@end
