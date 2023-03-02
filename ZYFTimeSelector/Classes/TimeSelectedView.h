//
//  TimeSelectedView.h
//  SchedulePlan
//
//  Created by 张云飞 on 2019/3/29.
//  Copyright © 2019年 张云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum IntervalType{
    one_minute,
    five_minute
}IntervalState;
typedef void (^Mytimeblck) (NSString * timestr);
@interface TimeSelectedView : UIView<UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIView * blackView;
@property (nonatomic, strong) UIPickerView   *pickerView;
@property(nonatomic,strong)UILabel * label;//标题
@property(nonatomic,copy)NSString * timeStr;//回传的时间
@property(nonatomic,copy) Mytimeblck timeBlockA;

@property(nonatomic,assign)IntervalState interval; //时间间隔  默认一分钟   可以改为 5 分钟

@property(nonatomic,copy)NSString * initialTimeStr;//初始时间

-(void)pop;
@end

NS_ASSUME_NONNULL_END
