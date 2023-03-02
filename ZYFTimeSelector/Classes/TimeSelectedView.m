
//
//  TimeSelectedView.m
//  SchedulePlan
//
//  Created by 张云飞 on 2019/3/29.
//  Copyright © 2019年 张云飞. All rights reserved.
//

#import "TimeSelectedView.h"
#import "UIView+ZYFMethods.h"
#import "TimeTools.h"

#define WeakSelf(weakSelf) __weak typeof(self) weakSelf = self;
#define kZYFScreenWidth [UIScreen mainScreen].bounds.size.width
#define kZYFScreenHeight [UIScreen mainScreen].bounds.size.height
#define StartandEndwidth ((kZYFScreenWidth-Scale(50))-Scale(60))
#define kZYFScreenBounds [UIScreen mainScreen].bounds
//宽度对比的比例值
#define scaleSize kZYFScreenWidth/375
//按比例计算后的值得大小
#define Scale(size) scaleSize*size
@interface TimeSelectedView ()
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

@property(assign,nonatomic)NSInteger indexA;
@property(assign,nonatomic)NSInteger indexB;
@property(assign,nonatomic)NSInteger indexC;
@property(assign,nonatomic)NSInteger indexD;
@property(assign,nonatomic)NSInteger indexE;
@end
@implementation TimeSelectedView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.frame = kZYFScreenBounds;
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.interval = 1;
        self.timeArrA=[NSMutableArray array];
        self.timeArrB=[NSMutableArray array];
        self.nianArr=[NSMutableArray array];
        self.yueArr=[NSMutableArray array];
        self.riArr=[NSMutableArray array];
    }
    return self;
}
-(void)pop{
    [self initUI];
    [self zyf_showInAppWindowAnimation];
}

-(void)initUI{
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView:)];
    tap.delegate=self;
    [self addGestureRecognizer:tap];
    
    self.blackView=[[UIView  alloc] initWithFrame:CGRectMake(0, 0, kZYFScreenWidth-Scale(50), Scale(220))];
    self.blackView.center=CGPointMake(kZYFScreenWidth/2, kZYFScreenHeight/2);
    self.blackView.backgroundColor=[UIColor whiteColor];
    self.blackView.layer.cornerRadius=Scale(10);
    [self addSubview:self.blackView];
    
    
    //改变透明度即可实现效果
    WeakSelf(myself);
    self.blackView.alpha=0;
    [UIView animateWithDuration:0.5 animations:^{
        myself.blackView.alpha = 1.0;
        myself.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [myself layoutIfNeeded];
    }];
    
    
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kZYFScreenWidth-Scale(50), Scale(45))];
    view.layer.cornerRadius=Scale(10);
    view.backgroundColor=[UIColor whiteColor];
    
    UIButton * btn=[[UIButton alloc] initWithFrame:CGRectMake(0, Scale(7), Scale(60), Scale(30))];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    self.label=[[UILabel alloc] initWithFrame:CGRectMake((kZYFScreenWidth-Scale(50))/2-Scale(50), 0, Scale(100), Scale(45))];
    self.label.text = @"选择时间";
    self.label.textColor=[UIColor blackColor];
    self.label.font = [UIFont systemFontOfSize:17];
    self.label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:self.label];
    
    
    UIButton * btnB=[[UIButton alloc] initWithFrame:CGRectMake(kZYFScreenWidth-Scale(50)-Scale(60), Scale(7), Scale(60), Scale(30))];
    [btnB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnB setTitle:@"确定" forState:UIControlStateNormal];
    btnB.titleLabel.font=[UIFont systemFontOfSize:14];
    [btnB addTarget:self action:@selector(qiedingAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnB];
    
    UIView * linview=[[UIView alloc] initWithFrame:CGRectMake(0, Scale(44), kZYFScreenWidth-Scale(50), 0.6)];
    linview.backgroundColor=[UIColor grayColor];
    [view addSubview:linview];
    [self.blackView addSubview:view];

    //pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(Scale(20), Scale(45), (kZYFScreenWidth-Scale(50))-Scale(40), Scale(165))];
    self.pickerView.backgroundColor=[UIColor whiteColor];
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    [self.blackView addSubview:self.pickerView];

    //年
    for (int i=-20; i<20; i++) {
        NSString * str=[TimeTools getCurrentTime:YYYY];
        int nian = [str intValue]-i;
        NSString * timestr=[NSString stringWithFormat:@"%d",nian];
        [self.nianArr addObject:timestr];
    }
    NSString * str=[NSString string];
    if (_initialTimeStr.length>0) {
        str=[_initialTimeStr substringWithRange:NSMakeRange(0, 4)];
    }else{
        str=[TimeTools getCurrentTime:YYYY];
    }
    NSString * nianstr=[TimeTools getCurrentTime:YYYY];
    int cha=[str intValue]-[nianstr intValue];
    
    
    self.nian=20-cha;
    //月
    for (int i=1; i<13; i++) {
        NSString * str=[NSString stringWithFormat:@"%02d",i];
        [self.yueArr addObject:str];
    }
    // 当前   月
    NSString * currentYue=[NSString string];
    if (_initialTimeStr.length>0) {
        currentYue=[_initialTimeStr substringWithRange:NSMakeRange(5, 2)];
    }else{
        currentYue=[TimeTools getCurrentTime:MM];
    }
    for (int i=0; i<self.yueArr.count; i++) {
        NSString * yue=[NSString stringWithFormat:@"%02d",[self.yueArr[i] intValue]];
        if ([currentYue isEqualToString:yue]) {
            self.yue=i;
        }
    }
    //日
    [self getMMDDMessage:self.nianArr[self.nian] andYue:self.yueArr[self.yue]];
    
    // 时
    for (int i=0;i<24; i++) {
        NSString * str=[NSString stringWithFormat:@"%02d",i];
        [self.timeArrA addObject:str];
    }
    self.timeArrC=@[@":",@":",@":",@":"];
    // 分
    for (int i=0;i<60; i=i+self.interval) {
        NSString * str=[NSString stringWithFormat:@"%02d",i];
        [self.timeArrB addObject:str];
    }
    
    // 当前   日
    NSString * currentRi=[NSString string];
    if (_initialTimeStr.length>0) {
        currentRi=[_initialTimeStr substringWithRange:NSMakeRange(8, 2)];
    }else{
        currentRi=[TimeTools getCurrentTime:DD];
    }
    for (int i=0; i<self.riArr.count; i++) {
        NSString * ri=[NSString stringWithFormat:@"%02d",[self.riArr[i] intValue]];
        if ([currentRi isEqualToString:ri]) {
            self.ri=i;
        }
    }
    
    NSString *strA=[NSString string];
    NSString *strB=[NSString string];
    if (_initialTimeStr.length>0&&_initialTimeStr.length>16) {//  有 时分
        strA=[_initialTimeStr substringWithRange:NSMakeRange(11, 2)];
        strB=[_initialTimeStr substringWithRange:NSMakeRange(14, 2)];
    }else{
        NSString * str=[TimeTools getCurrentTime:HHMM];
        NSArray * arr=[str componentsSeparatedByString:@":"];
        strA=arr[0];
        NSString *fenstr=arr[1];
        NSInteger fen=[fenstr integerValue];
        NSInteger fenB=5-fen%5+fen;//  取5的整数倍
        strB=[NSString stringWithFormat:@"%02ld",(long)fenB];
    }

    for (int i=0; i<self.timeArrA.count; i++) {
        NSString * s=self.timeArrA[i];
        if ([strA isEqualToString:s]) {
            self.sumA=i;
        }
    }
    for (int i=0; i<self.timeArrB.count; i++) {
        NSString * s=self.timeArrB[i];
        if ([strB isEqualToString:s]) {
            self.sumB=i;
        }
    }
    
    //默认选中
    self.indexA=[self.nianArr count]*500+self.nian;
    self.indexB=[self.yueArr count]*500+self.yue;
    self.indexC=[self.riArr count]*500+self.ri;
    self.indexD=[self.timeArrA count]*500+self.sumA;
    self.indexE=[self.timeArrB count]*500+self.sumB;

    [self.pickerView selectRow:[self.nianArr count]*500+self.nian inComponent:0 animated:NO];
    [self.pickerView selectRow:[self.yueArr count]*500+self.yue inComponent:1 animated:NO];
    [self.pickerView selectRow:[self.riArr count]*500+self.ri inComponent:2 animated:NO];
    [self.pickerView selectRow:[self.timeArrA count]*500+self.sumA inComponent:4 animated:NO];
    [self.pickerView selectRow:1 inComponent:5 animated:NO];
    [self.pickerView selectRow:[self.timeArrB count]*500+self.sumB inComponent:6 animated:NO];

    
    //时间初始化
    self.timeStr=[NSString stringWithFormat:@"%@-%@-%@ %@:%@",self.nianArr[_nian],self.yueArr[_yue],self.riArr[_ri],self.timeArrA[_sumA],self.timeArrB[_sumB]];
    
    NSString * week=[NSString stringWithFormat:@"%@-%@-%@",self.nianArr[_nian],self.yueArr[_yue],self.riArr[_ri]];
    
    self.weekLable=[[UILabel alloc] initWithFrame:CGRectMake(StartandEndwidth/2+Scale(46),Scale(100), StartandEndwidth/6, Scale(55))];
    self.weekLable.text=[TimeTools weekdayStringFromDate:week];
    self.weekLable.textColor = [UIColor blackColor];
    self.weekLable.font = [UIFont systemFontOfSize:15];
    self.weekLable.textAlignment = NSTextAlignmentCenter;
    [self.blackView addSubview:self.weekLable];
    
    //创建一个view  遮挡  ：  不让他滚动
    UIView * clearview=[[UIView alloc] initWithFrame:CGRectMake(kZYFScreenWidth-Scale(85)-StartandEndwidth/6,0, Scale(20), Scale(200))];
    [self.blackView addSubview:clearview];
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 7;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return self.nianArr.count*1000;
    }else if (component==1){
        return self.yueArr.count*1000;
    }else if (component==2){
        return self.riArr.count*1000;
    }else if (component==3){
        return 0;
    }else if (component==4){
        return self.timeArrA.count*1000;
    }else if (component==5){
        return self.timeArrC.count;
    }else{
        return self.timeArrB.count*1000;
    }
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return [NSString stringWithFormat:@"%@年",self.nianArr[row%40]];
    }else if (component==1){
        return [NSString stringWithFormat:@"%@月",self.yueArr[row%12]];
    }else if (component==2){
        return [NSString stringWithFormat:@"%@日",self.riArr[row%[self.riArr count]]];
    }else if (component==3){
        return @"";
    }else if (component==4){
        return self.timeArrA[row%24];
    }else if (component==5){
        return self.timeArrC[row];
    }else{
        return self.timeArrB[row%(60/self.interval)];
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //停止滚动代理方法
    if (component==0) {
        self.indexA=row;
        self.nian=(int)row%40;
        [self getDays];
    }else if (component==1){
        self.indexB=row;
        self.yue=(int)row%12;
        [self getDays];
    }else if (component==2){
        self.indexC=row;
        self.ri=(int)row%[self.riArr count];
    }else if (component==3){
    }else if (component==4) {
        self.indexD=row;
        self.sumA = (int)row%24;
    }else if (component==5){
    }else{
        self.indexE=row;
        self.sumB = (int)row%(60/self.interval);
    }
    
    [self.pickerView reloadAllComponents];
    
    NSString * week=[NSString stringWithFormat:@"%@-%@-%@",self.nianArr[self.nian],self.yueArr[_yue],self.riArr[_ri]];
    self.weekLable.text=[TimeTools weekdayStringFromDate:week];

    self.timeStr=[NSString stringWithFormat:@"%@-%@-%@ %@:%@",self.nianArr[_nian],self.yueArr[_yue],self.riArr[_ri],self.timeArrA[_sumA],self.timeArrB[_sumB]];
}
// 选择年份 月份 后 重新 计算日期
-(void)getDays{
    [self getMMDDMessage:self.nianArr[self.nian] andYue:self.yueArr[self.yue]];// 根据年份 月份 取日 数据
    self.indexC=[self.riArr count]*500+self.ri;
    [self.pickerView selectRow:[self.riArr count]*500+self.ri inComponent:2 animated:NO];
    [self.pickerView selectRow:[self.timeArrA count]*500+self.sumA inComponent:4 animated:NO];
    [self.pickerView selectRow:1 inComponent:5 animated:NO];
    [self.pickerView selectRow:[self.timeArrB count]*500+self.sumB inComponent:6 animated:NO];
    //重新加载  self.pickerView
    [self.pickerView reloadAllComponents];
}

//每一列组件的列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component==0) {
        return StartandEndwidth/6+Scale(15);
    }else if (component==1){
        return StartandEndwidth/6-Scale(0);
    }else if (component==2){
        return StartandEndwidth/6-Scale(5);
    }else if (component==3){
        return StartandEndwidth/6-Scale(15);
    }else if (component==4) {
        return StartandEndwidth/6-Scale(15);
    }else if (component==5){
        return Scale(5);
    }else{
        return StartandEndwidth/6-Scale(10);
    }
}

//每一列组件的行高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return Scale(55);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
  
    for (UIView * singleLine in pickerView.subviews) {
        if (singleLine.frame.size.height < 1) {
            singleLine.backgroundColor = [UIColor blackColor];
        }
    }
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor=[UIColor blackColor];;
        pickerLabel.textAlignment=NSTextAlignmentCenter;
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
    }

    if (component==0&&row==_indexA) {
        pickerLabel.textColor=[UIColor blackColor];
    }
    if (component==1&&row==_indexB) {
        pickerLabel.textColor=[UIColor blackColor];
    }
    if (component==2&&row==_indexC) {
        pickerLabel.textColor=[UIColor blackColor];
    }
    if (component==4&&row==_indexD) {
        pickerLabel.textColor=[UIColor blackColor];
    }
    if (component==5&&row==1) {
        pickerLabel.textColor=[UIColor blackColor];
    }
    if (component==6&&row==_indexE) {
        pickerLabel.textColor=[UIColor blackColor];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];

    return pickerLabel;
}


//确定   和  取消
-(void)cancelAction:(UIButton *)sender{
    [self removeSuperview];
}
-(void)qiedingAction:(UIButton *)sedner{
    
    if (self.timeBlockA != nil){
        self.timeBlockA(self.timeStr);
    }
    [self removeSuperview];
}

-(void)removeView:(UITapGestureRecognizer *)sender{
    [self removeSuperview];
}

-(void)removeSuperview{
    WeakSelf(myself);
    [UIView animateWithDuration:0.5 animations:^{
        myself.blackView.alpha = 0;
        myself.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        [myself removeFromSuperview];
    }];
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.blackView]) {
        return NO;
    }
    return YES;
}

// 辅助方法
-(void)getMMDDMessage:(NSString *)year andYue:(NSString *)yue{
    [self.riArr removeAllObjects];
    NSInteger sum=[year integerValue];
    if ([self daysCountOfYear:sum]) {
        int int_yue=[yue intValue];
        if (int_yue==1||int_yue==3||int_yue==5||int_yue==7||int_yue==8||int_yue==10||int_yue==12) {
            for (int j=1; j<32;j++) {
                NSString * ristr=[NSString stringWithFormat:@"%02d",j];
                [self.riArr addObject:ristr];
            }
            self.ri=30;// 防止数组越界
            return;
        }
        if (int_yue==3||int_yue==4||int_yue==6||int_yue==7||int_yue==9||int_yue==11) {
            for (int k=1; k<31;k++) {
                NSString * ristr=[NSString stringWithFormat:@"%02d",k];
                [self.riArr addObject:ristr];
            }
            self.ri=29;// 防止数组越界
            return;
        }
        if (int_yue==2) {
            for (int h=1; h<30; h++) {
                NSString * ristr=[NSString stringWithFormat:@"%02d",h];
                [self.riArr addObject:ristr];
            }
            self.ri=28;// 防止数组越界
            return;
        }
    }else{
        int int_yue=[yue intValue];
        if (int_yue==1||int_yue==3||int_yue==5||int_yue==7||int_yue==8||int_yue==10||int_yue==12) {
            for (int j=1; j<32;j++) {
                NSString * ristr=[NSString stringWithFormat:@"%02d",j];
                [self.riArr addObject:ristr];
            }
            self.ri=30;// 防止数组越界
            return;
        }
        if (int_yue==3||int_yue==4||int_yue==6||int_yue==7||int_yue==9||int_yue==11) {
            for (int k=1; k<31;k++) {
                NSString * ristr=[NSString stringWithFormat:@"%02d",k];
                [self.riArr addObject:ristr];
            }
            self.ri=29;// 防止数组越界
            return;
        }
        if (int_yue==2) {
            for (int h=1; h<29; h++) {
                NSString * ristr=[NSString stringWithFormat:@"%02d",h];
                [self.riArr addObject:ristr];
            }
            self.ri=27;// 防止数组越界
            return;
        }
    }
}
-(BOOL) daysCountOfYear:(NSInteger) year //是否是 闰年     平年2月 28天   润年2月 29天
{
    if(year%4==0 && year%100!=0)//普通年份，非100整数倍
        return YES;//29
    if(year%400 == 0)
        //世纪年份
        return YES; //29
    return NO;
}


+(UIColor *)colorWithHexString: (NSString *)color andAlpha:(CGFloat)alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}
@end
