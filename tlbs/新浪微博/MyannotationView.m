//
//  MyannotationView.m
//  新浪微博
//
//  Created by tarena6 on 15-4-9.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "MyannotationView.h"

@implementation MyannotationView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"img_07.png"];
    }
    return self;
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.image = [UIImage imageNamed:@"img_03.png"];
    }else{
        self.image = [UIImage imageNamed:@"img_07.png"];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
