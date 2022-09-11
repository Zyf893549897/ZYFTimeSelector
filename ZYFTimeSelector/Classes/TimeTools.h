//
//  TimeTools.h
//  timeselect
//
//  Created by 张云飞 on 2022/9/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//定义枚举类型
typedef enum TimeStyle{
    MMDD,
    YYYYMMDD,
    YYYY_MM_DD,
    HHMMSS,
    YYYYMMDDHHMMSS,
    MMDDHHMM,
    MMSS,
    HHMM,
    YYYYMMDDHHMM,
    YYYYMM,
    YYYY,
    MM,
    DD
}TimeState;
@interface TimeTools : NSObject
//时间戳--->时间
+(NSString *)transToTime:(TimeState)state andtime:(NSString *)timsp;

//获取当前时间
+(NSString*)getCurrentTime:(TimeState)type;

//根据日期计算星期几
+ (NSString*)weekdayStringFromDate:(NSString *)timestr;
@end

NS_ASSUME_NONNULL_END
