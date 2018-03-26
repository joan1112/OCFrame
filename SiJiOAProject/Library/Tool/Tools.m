//
//  Tools.m
//  iOSpro
//
//  Created by sj on 16/11/10.
//  Copyright © 2016年 sjjy. All rights reserved.
//

#import "Tools.h"

@implementation Tools
//手机号判断
+(BOOL)isMobileNumber:(NSString *)mobileNum{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobileNum];
}

//email判断
+(BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//密码长度是否纯数字特殊字符判断
+(BOOL)isValidatPassWord:(NSString *)psStr{
    NSString *psRegex = @"^(?=.*\\d)((?=.*[a-z])|(?=.*[A-Z])).{6,20}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", psRegex];
    return [emailTest evaluateWithObject:psStr];
}
//json格式的字符串转换为字典
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        DLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//字典转json字符串
+(NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//去除字典中的null
+(NSMutableDictionary *)deleteAllNull :(NSMutableDictionary *)dic{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in dic.allKeys) {
        if ([[dic objectForKey:keyStr] isEqual:[NSNull null]]) {
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else{
            [mutableDic setObject:[dic objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}

//比较一个日期是在过去还是未来 A>B
+(int)compareOneDay:(NSDate *)oneDay :(NSString *)format{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:currentDate];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {//下降a>b
        return 1;
    }else if (result == NSOrderedAscending){
        return -1;
    }else{
        return 0;
    }
}

//将一个秒数转换为几时几分几秒
+(NSMutableArray *)timeFormatted:(int)totalSeconds{
    NSMutableArray *result;
    [result removeAllObjects];
    int hours = totalSeconds / 3600;
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    result=[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%02d",hours],[NSString stringWithFormat:@"%02d",minutes],[NSString stringWithFormat:@"%02d",seconds], nil];
    return result;
}


//将一个秒数转换为几分几秒
+(NSMutableArray *)timeFormatted2:(int)totalSeconds{
    NSMutableArray *result;
    [result removeAllObjects];
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    result=[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%02d",minutes],[NSString stringWithFormat:@"%02d",seconds], nil];
    return result;
}

//字符串转date
+(NSDate *)getdate:(NSMutableString*)date :(NSString *)format{
    NSMutableString *dat = [NSMutableString stringWithString:date];
    [dat insertString:@"-" atIndex:4];
    [dat insertString:@"-" atIndex:7];
    NSDateFormatter*df = [[NSDateFormatter alloc]init];
    [df setDateFormat:format];
    NSDate *datestart = [df dateFromString:dat];
    return datestart;
}

//获得一个时间到当前时间的秒数
+(NSInteger)getSecond :(NSString *)timestr :(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    NSDate *someDayDate = [dateFormatter dateFromString:timestr];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval time=[currentDate timeIntervalSinceDate:someDayDate];
    return time;
}

+(NSString *)intervalSinceNow: (NSString *) theDate :(NSString *)format{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:format];
    NSDate *d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha=late-now;
    timeString = [NSString stringWithFormat:@"%f",cha];
    timeString = [timeString substringToIndex:timeString.length-7];
    return timeString;
}

//获取周几
+(NSString*)weekdayStringFromDate:(NSDate*)inputDate{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

//获取当前时间
+(NSString*)getCurrentTime :(NSString *)format{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//去重
+(NSMutableArray *)arrayWithMemberIsOnly:(NSMutableArray *)array{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [array count]; i++) {
        if ([categoryArray containsObject:[array objectAtIndex:i]] == NO){
            [categoryArray addObject:[array objectAtIndex:i]];
        }
    }
    return categoryArray;
}

//判断字符串内是否包含中文
+(BOOL)isContainChinese:(NSString*)str{
    BOOL flag=NO;
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if(a>0x4e00&&a<0x9fff){
            flag=YES;
            break;
        }
    }
    return flag;
}

//循环删除数组中多个指定元素
+(NSMutableArray *)removeIndexFromArr :(NSMutableArray *)arr :(NSString *)idx{
    NSMutableArray *tmptmp=[NSMutableArray arrayWithArray:arr];
    NSMutableArray *removeIndex=[[NSMutableArray alloc]init];
    for (int i=0; i<tmptmp.count; i++) {
        if ([tmptmp[i]isEqualToString:idx]) {
            [removeIndex addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    int count=0;
    for (int i = 0; i < removeIndex.count; i++) {
        int number = [removeIndex[i] intValue];
        number=number-count;
        count++;
        [tmptmp removeObjectAtIndex:number];
    }
    return tmptmp;
}

//单个数组排序
+(NSMutableArray *)arraySort :(NSMutableArray *)arr{
    NSArray *array = [arr sortedArrayUsingSelector:@selector(compare:)];
    return [array mutableCopy];
}

//多个数组排序
+(NSMutableArray *)muArraySort :(NSMutableArray *)arr1 :(NSMutableArray *)arr2{
    for (int i=0; i<arr1.count; i++) {
        for (int j=0; j<arr1.count-i-1; j++) {
            if ([arr1[j+1]integerValue]<[arr1[j]integerValue]) {
                NSInteger tmp=[arr1[j]integerValue];
                NSString *tmp2=[NSString stringWithFormat:@"%@",arr2[j]];
                arr1[j]=[NSNumber numberWithInteger:[arr1[j+1]integerValue]];
                arr2[j]=[NSString stringWithFormat:@"%@",arr2[j+1]];
                arr1[j+1]=[NSNumber numberWithInteger:tmp];
                arr2[j+1]=[NSString stringWithFormat:@"%@",tmp2];
            }
        }
    }
    NSMutableArray *arr=[NSMutableArray arrayWithObjects:arr1,arr2, nil];
    return arr;
}

//md5加密
+(NSString*)md5:(NSString*)imput{
    const char* str=[imput UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str,(CC_LONG)strlen(str),result);
    NSMutableString *md5ret=[NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [md5ret appendFormat:@"%x",result[i]];
    }
    return md5ret;
}

+(NSDate *)changeDate :(NSString *)datestr :(NSString *)format{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSDate *date =[dateFormat dateFromString:datestr];
    return date;
}

+(void)hideLine:(UITableView *)tableView{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 20)];
    view.backgroundColor=[UIColor clearColor];
    [tableView setTableFooterView:view];
}

+ (CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width font:(CGFloat)font{
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, 999)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect.size.height;
}

+(NSString *)timeAddtime :(NSDate *)date :(NSString *)second{
//    NSDate *dates = [NSDate date];
    NSTimeInterval interval = [second integerValue]*60;
    NSDate *detea = [NSDate dateWithTimeInterval:interval sinceDate:date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"BeiJing"];
    [dateformatter setTimeZone:timeZone];
    return [dateformatter stringFromDate:detea];
}

+(NSMutableArray *)getnewArr :(NSMutableArray *)arr{
    for(int i = 0 ; i < arr.count ; i++){
        NSString *item = arr[i];
        if([item isEqualToString:@"-"]){
            continue;
        }else{
            //找下一个有数据点
            for(int j = i+1 ; j < arr.count;j ++){
                if(![arr[j] isEqualToString:@"-"]){//则从i 到 j 的点都附上值
                    NSString *next = arr[j];
                    for(int m = i+1 ; m < j; m++){
                        arr[m] = [NSString stringWithFormat:@"%f",([next doubleValue]-[item doubleValue])/(j-i) *(m-i)+[item doubleValue]];
                    }
                    i = j;
                    i--;
                    break;
                }
            }
        }
    }
    return arr;
}


+ (BOOL)getIsIpad

{
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    
    
    if([deviceType isEqualToString:@"iPhone"]) {
        
        //iPhone
        
        return NO;
        
    }
    
    else if([deviceType isEqualToString:@"iPod touch"]) {
        
        //iPod Touch
        
        return NO;
        
    }
    
    else if([deviceType isEqualToString:@"iPad"]) {
        
        //iPad
        
        return YES;
        
    }
    
    return NO;
    
}

+(CGFloat)getNavHeight;
{
   
    return 44+[UIApplication sharedApplication].statusBarFrame.size.height;
}
@end
