//
//  ZXSBadgeView.m
//  ZXSOCAPP
//
//  Created by ZXS Coder on 2019/4/6.
//  Copyright © 2019 CoderZXS. All rights reserved.
//

#import "ZXSBadgeView.h"

@interface ZXSBadgeView()

@property (nonatomic, strong) UILabel *badgeLabel;

@end


@implementation ZXSBadgeView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.font = [UIFont systemFontOfSize:13];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.backgroundColor = [UIColor clearColor];
        [_badgeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self addSubview:_badgeLabel];
        [_badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(3);
            make.bottom.equalTo(self).offset(-3);
            make.left.equalTo(self).offset(3);
            make.right.equalTo(self).offset(-3);
        }];
    }
    
    return self;
}

- (void)setValue:(NSString *)value {
    self.badgeLabel.text = value;
}

- (void)setFont:(UIFont *)font {
    self.badgeLabel.font = font;
}

@end
