//
//  RequestManager.h
//  SiJiOAProject
//
//  Created by qiong on 2018/2/26.
//  Copyright © 2018年 qiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject
+ (AFHTTPSessionManager*)defaultNetManager;
+(void)clearCookies;

//Post请求
+(void)PostWithParameters:(id)Parameters
                   SubUrl:(NSString *)Suburl
                     Bool:(BOOL)show
                     view:(UIView *)View
                    Block:(void (^)(NSData *data, NSString *jsonstr, NSError *error ,NSString *isNet))Block;

+(void)upladWithParameters:(id)Parameters
                    SubUrl:(NSURL *)url
                      view:(UIView *)View
                     Block:(void (^)(NSData *data, NSString *jsonstr, NSError *error ,NSString *isNet))Block;
@end
