//
//  UIView+ZYFMethods.m
//  timeselect
//
//  Created by 张云飞 on 2022/9/11.
//

#import "UIView+ZYFMethods.h"

@implementation UIView (ZYFMethods)
- (void)zyf_showInAppWindowAnimation{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 1;
        [self layoutIfNeeded];
    }];
}
@end
