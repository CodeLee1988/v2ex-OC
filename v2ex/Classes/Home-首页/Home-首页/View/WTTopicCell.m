//
//  WTBlogCell.m
//  v2ex
//
//  Created by 无头骑士 GJ on 16/1/14.
//  Copyright © 2016年 无头骑士 GJ. All rights reserved.
//

#import "WTTopicCell.h"
#import "UIImageView+WebCache.h"
#import "WTTopicViewModel.h"
#import "UILabel+StringFrame.h"
#import "NSString+Regex.h"
#import "UIImage+Extension.h"

NS_ASSUME_NONNULL_BEGIN

@interface WTTopicCell ()

/** 头像*/
@property (weak, nonatomic) IBOutlet UIImageView            *iconImageV;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel                *titleLabel;
/** 节点 */
@property (weak, nonatomic) IBOutlet UIButton               *nodeBtn;
/** 最后回复时间 */
@property (weak, nonatomic) IBOutlet UILabel                *lastReplyTimeLabel;
/** 作者 */
@property (weak, nonatomic) IBOutlet UILabel                *authorLabel;
/** 回复数 */
@property (weak, nonatomic) IBOutlet UIImageView            *commentCountImageView;
/** 回复数 */
@property (weak, nonatomic) IBOutlet UILabel                *commentCountLabel;

@end
@implementation WTTopicCell

- (void)awakeFromNib
{
    // 2、节点
    self.nodeBtn.layer.cornerRadius = 1.5;
    self.iconImageV.layer.cornerRadius = 5;
    self.iconImageV.layer.masksToBounds = YES;
}

// 重写 blog set方法，初始化数据
- (void)setTopicViewModel:(WTTopicViewModel *)topicViewModel
{
    _topicViewModel = topicViewModel;

    // 1、头像
    [self.iconImageV sd_setImageWithURL: topicViewModel.iconURL placeholderImage: WTIconPlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconImageV.image = [image roundImageWithCornerRadius: 3];
        self.iconImageV.image = image;
    }];
    
    // 2、标题
    self.titleLabel.text = topicViewModel.topic.title;
    
    // 3、节点
    NSString *node = topicViewModel.topic.node;
    // 判断是否包含中文字符串
    if ([NSString isChineseCharactersWithString: node] || node.length > 4)
    {
        //NSLog(@"中文:%@", _blog.node);
        node = [NSString stringWithFormat: @" %@ ", topicViewModel.topic.node];
    }
    [self.nodeBtn setTitle: node forState: UIControlStateNormal];
    
    // 4、最后回复时间
    self.lastReplyTimeLabel.text = topicViewModel.topic.lastReplyTime;
    
    // 6、作者
    self.authorLabel.text = topicViewModel.topic.author;
    
    // 7、评论数
    self.commentCountLabel.text = topicViewModel.topic.commentCount;
    self.commentCountImageView.hidden = !(topicViewModel.topic.commentCount.length > 0);
}

@end
NS_ASSUME_NONNULL_END
