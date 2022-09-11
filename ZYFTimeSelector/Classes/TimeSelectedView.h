//
//  TimeSelectedView.h
//  SchedulePlan
//
//  Created by 张云飞 on 2019/3/29.
//  Copyright © 2019年 张云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^Mytimeblck) (NSString * timestr);
@interface TimeSelectedView : UIView<UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIView * blackView;
@property (nonatomic, strong) UIPickerView   *pickerView;
@property(nonatomic,strong)UILabel * label;//标题

@property(nonatomic,copy)NSString * timeStr;//回传的时间
@property(nonatomic,copy)NSString * type;//标题   1 表示开始时间  2表示结束时间

@property(nonatomic,strong)UILabel * weekLable;//  周几

@property (nonatomic, strong)NSMutableArray * nianArr;// 年 数据源
@property (nonatomic, strong)NSMutableArray * yueArr;// 月 数据源
@property (nonatomic, strong)NSMutableArray * riArr;// 日 数据源
@property (nonatomic, strong)NSMutableArray * timeArrA;// 时 数据源
@property (nonatomic, strong)NSMutableArray * timeArrB;// 分 数据源
@property (nonatomic, strong)NSArray * timeArrC;// : 数据源

@property(nonatomic,assign)int sumA;//时  记录位置用
@property(nonatomic,assign)int sumB;//分
@property(nonatomic,assign)int nian;
@property(nonatomic,assign)int yue;
@property(nonatomic,assign)int ri;

@property(nonatomic,copy) Mytimeblck timeBlockA;



@property(nonatomic,copy)NSString * initialTimeStr;//初始时间


@property(assign,nonatomic)NSInteger indexA;
@property(assign,nonatomic)NSInteger indexB;
@property(assign,nonatomic)NSInteger indexC;
@property(assign,nonatomic)NSInteger indexD;
@property(assign,nonatomic)NSInteger indexE;


-(void)initUI;

@end

NS_ASSUME_NONNULL_END
