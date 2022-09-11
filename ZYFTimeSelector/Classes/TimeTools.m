//
//  TimeTools.m
//  timeselect
//
//  Created by 张云飞 on 2022/9/11.
//

#import "TimeTools.h"

@implementation TimeTools
//格局需求初获取 formatter 对象
+(NSDateFormatter *)getTimeFormatter:(TimeState)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];//设置本地时区
    //设定时间格式,这里可以设置成自己需要的格式
    switch (format) {
        case YYYYMMDD:
            [formatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case HHMMSS:
            [formatter setDateFormat:@"HH:mm:ss"];
            break;
        case YYYYMMDDHHMMSS:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case MMSS:
            [formatter setDateFormat:@"mm:ss"];
            break;
        case YYYYMMDDHHMM:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case MMDDHHMM:
            [formatter setDateFormat:@"MM-dd HH:mm"];
            break;
        case HHMM:
            [formatter setDateFormat:@"HH:mm"];
            break;
        case YYYYMM:
            [formatter setDateFormat:@"yyyy-MM"];
            break;
        case YYYY:
            [formatter setDateFormat:@"yyyy"];
            break;
        case MM:
            [formatter setDateFormat:@"MM"];
            break;
        case DD:
            [formatter setDateFormat:@"dd"];
            break;
        case MMDD:
            [formatter setDateFormat:@"MM-dd"];
            break;
        default:
            [formatter setDateFormat:@"yyyy-MM-dd"];
            break;
    }
    return formatter;
}
//时间戳--->时间
+(NSString *)transToTime:(TimeState)format andtime:(NSString *)timsp{
    NSTimeInterval time=[timsp doubleValue];//如果不使用本地时区,因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [[self getTimeFormatter:format] stringFromDate: detaildate];
    return currentDateStr;
}
//获取当前时间
+(NSString*)getCurrentTime:(TimeState)format{
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [[self getTimeFormatter:format] stringFromDate:datenow];
    return currentTimeString;
}
//根据日期计算星期几
+ (NSString*)weekdayStringFromDate:(NSString *)timestr {
    
    NSDate * inputDate = [self dateFortimeStr:timestr];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}
//日期转data
+(NSDate *)dateFortimeStr:(NSString *)time{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *data = [format dateFromString:time];
    return data;
}
@end
