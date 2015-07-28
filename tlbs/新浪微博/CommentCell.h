//
//  CommentCell.h
//  新浪微博
//
//  Created by tarena6 on 15-4-7.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
@interface CommentCell : UITableViewCell
@property (nonatomic,strong)Comment *comment;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) UITextView *textV;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
