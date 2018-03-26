//
//  Tools.h
//  iOSpro
//
//  Created by sj on 16/11/10.
//  Copyright © 2016年 sjjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface Tools : NSObject
+(BOOL)isMobileNumber:(NSString *)mobileNum;
+(BOOL)isValidateEmail:(NSString *)email;
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+(NSMutableDictionary *)deleteAllNull :(NSMutableDictionary *)dic;
+(int)compareOneDay:(NSDate *)oneDay :(NSString *)format;
+(NSMutableArray *)arrayWithMemberIsOnly:(NSMutableArray *)array;
+(NSMutableArray *)timeFormatted:(int)totalSeconds;
+(NSInteger)getSecond :(NSString *)timestr :(NSString *)format;
+(NSString*)weekdayStringFromDate:(NSDate*)inputDate;
+(NSString*)getCurrentTime :(NSString *)format;
+(BOOL)isContainChinese:(NSString*)str;
+(NSMutableArray *)removeIndexFromArr :(NSMutableArray *)arr :(NSString *)idx;
+(NSMutableArray *)arraySort :(NSMutableArray *)arr;
+(NSMutableArray *)muArraySort :(NSMutableArray *)arr1 :(NSMutableArray *)arr2;
+(NSString*)dictionaryToJson:(NSDictionary *)dic;
+(NSString*)md5:(NSString*)imput;
+(NSDate *)getdate:(NSMutableString*)date :(NSString *)format;
+(NSDate *)changeDate :(NSString *)datestr :(NSString *)format;
+(NSString *)intervalSinceNow: (NSString *) theDate :(NSString *)format;
+(NSString *)timeAddtime :(NSDate *)date :(NSString *)second;
+(void)hideLine:(UITableView *)tableView;
+(NSMutableArray *)timeFormatted2:(int)totalSeconds;
+(BOOL)isValidatPassWord:(NSString *)psStr;
+ (CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width font:(CGFloat)font;
+(NSMutableArray *)getnewArr :(NSMutableArray *)arr;
+ (BOOL)getIsIpad;

+(CGFloat)getNavHeight;
@end
