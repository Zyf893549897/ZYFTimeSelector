//
//  UIView+ZYFMethods.m
//  timeselect
//
//  Created by 张云飞 on 2022/9/11.
//

#import "UIView+ZYFMethods.h"
#import "AppDelegate.h"
@implementation UIView (ZYFMethods)
- (void)zyf_showInAppWindowAnimation{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.window) {
        [app.window addSubview:self];
    }
    self.alpha = 0;
    [UIView animateWithDuration:.2 animations:^{
    self.alpha = 1;
    }];
}
@end
