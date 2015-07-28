//
//  CommentCell.m
//  新浪微博
//
//  Created by tarena6 on 15-4-7.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+AFNetworking.h"
@implementation CommentCell

- (void)awakeFromNib {
    self.textV = [[UITextView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.textV];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.imageV setImageWithURL:[NSURL URLWithString:self.comment.user.avatar_large]];
    self.nameLabel.text = self.comment.user.name;
    self.textV.frame = CGRectMake(93, 43, 200, [self.comment getCommentHeight]+6);
    self.textV.font = [UIFont systemFontOfSize:17];
    self.textV.text = self.comment.text;
    self.textV.userInteractionEnabled = NO;
    self.timeLabel.text = self.comment.created_at;
}
@end
