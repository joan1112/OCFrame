//
//  RequestManager.m
//  SiJiOAProject
//
//  Created by qiong on 2018/2/26.
//  Copyright © 2018年 qiong. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager
+ (AFHTTPSessionManager*)defaultNetManager {
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc]init];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 30;
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json",nil];
    });
    return manager;
}
//Post请求
+(void)PostWithParameters:(id)Parameters
                   SubUrl:(NSString *)Suburl
                     Bool:(BOOL)show
                     view:(UIView *)View
                    Block:(void (^)(NSData *data, NSString *jsonstr, NSError *error ,NSString *isNet))Block;
{
    AppDelegate *delegate =(AppDelegate*) [UIApplication sharedApplication].delegate;
    
    if (delegate.netWork) {
        [YJProgressHUD showMessage:@"" inView:View];
        
        NSString *url=[[[[@"" stringByAppendingString:Suburl]stringByAppendingString:@".php"]stringByAppendingString:@"?t="]stringByAppendingString:[Tools getCurrentTime:@"HH:mm:ss"]];
        
                AFHTTPSessionManager *manager = [RequestManager defaultNetManager];
                if ([Suburl isEqualToString:@""]) {
                    [self clearCookies];
                }
                NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:@""]];
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"kUserDefaultsCookie"];
                NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"kUserDefaultsCookie"];
                if([cookiesdata length]) {
                    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
                    NSHTTPCookie *cookie;
                    for (cookie in cookies) {
                        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
                    }
                }
        
                [manager POST:url parameters:Parameters progress:^(NSProgress * _Nonnull downloadProgress){
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                    NSString *reslut;
                    @try {
                        NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                        int i=0;
                        NSString *resultStr;
                        while (i<str.length) {
                            NSString *tmp=[str substringWithRange:NSMakeRange(i,1)];
                            if ([tmp isEqualToString:@"{"]) {
                                resultStr=[str substringFromIndex:i];
                                break;
                            }
                            i++;
                        }
                        NSData *data =[resultStr dataUsingEncoding:NSUTF8StringEncoding];
                        NSDictionary *Dic=[Tools deleteAllNull:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
                        reslut=[Tools dictionaryToJson:Dic];
                        [YJProgressHUD hide];
                        Block(nil,reslut,nil,nil);
                    } @catch (NSException *exception) {
                        [YJProgressHUD hide];
                        [YJProgressHUD showMessage:@"" inView:View];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error){
                    if (error.code == -1001) {
                        if (View!=nil) {
                            [YJProgressHUD showMessage:@"" inView:View];

                        }
                    }else if(error.code == -1011){
                        if (View!=nil) {
                            [YJProgressHUD showMessage:@"" inView:View];

                        }
                    }else{
                        [YJProgressHUD showMessage:@"" inView:View];
                    }
                    [YJProgressHUD hide];
                    Block(nil,nil,error,nil);
                }];
            }else{
        
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (View!=nil) {
                        [YJProgressHUD showMessage:@"" inView:View];
                    }
                });
        
               
    }


}

+(void)GetWithParameters:(id)Parameters
                  SubUrl:(NSString *)Suburl
                    Bool:(BOOL)show
                    view:(UIView *)View
                   Block:(void (^)(NSData *data, NSString *jsonstr, NSError *error ,NSString *isNet))Block;
{
    AppDelegate *delegate =(AppDelegate*) [UIApplication sharedApplication].delegate;
    
    if (delegate.netWork) {
        [YJProgressHUD showMessage:@"" inView:View];
        
        NSString *url=[[[[@"" stringByAppendingString:Suburl]stringByAppendingString:@".php"]stringByAppendingString:@"?t="]stringByAppendingString:[Tools getCurrentTime:@"HH:mm:ss"]];
        
        AFHTTPSessionManager *manager = [RequestManager defaultNetManager];
        if ([Suburl isEqualToString:@""]) {
            [self clearCookies];
        }
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:@""]];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"kUserDefaultsCookie"];
        NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"kUserDefaultsCookie"];
        if([cookiesdata length]) {
            NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
            NSHTTPCookie *cookie;
            for (cookie in cookies) {
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            }
        }
        
        [manager GET:url parameters:Parameters progress:^(NSProgress * _Nonnull downloadProgress){
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            NSString *reslut;
            @try {
                NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                int i=0;
                NSString *resultStr;
                while (i<str.length) {
                    NSString *tmp=[str substringWithRange:NSMakeRange(i,1)];
                    if ([tmp isEqualToString:@"{"]) {
                        resultStr=[str substringFromIndex:i];
                        break;
                    }
                    i++;
                }
                NSData *data =[resultStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *Dic=[Tools deleteAllNull:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
                reslut=[Tools dictionaryToJson:Dic];
                [YJProgressHUD hide];
                Block(nil,reslut,nil,nil);
            } @catch (NSException *exception) {
                [YJProgressHUD hide];
                [YJProgressHUD showMessage:@"" inView:View];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error){
            if (error.code == -1001) {
                if (View!=nil) {
                    [YJProgressHUD showMessage:@"" inView:View];
                    
                }
            }else if(error.code == -1011){
                if (View!=nil) {
                    [YJProgressHUD showMessage:@"" inView:View];
                    
                }
            }else{
                [YJProgressHUD showMessage:@"" inView:View];
            }
            [YJProgressHUD hide];
            Block(nil,nil,error,nil);
        }];
    }else{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (View!=nil) {
                [YJProgressHUD showMessage:@"" inView:View];
            }
        });
        
        
    }
}
+(void)upladWithParameters:(id)Parameters SubUrl:(NSURL *)Suburl view:(UIView *)View Block:(void (^)(NSData *, NSString *, NSError *, NSString *))Block
{
    AppDelegate *delegate =(AppDelegate*) [UIApplication sharedApplication].delegate;
    if (delegate.netWork) {
        AFHTTPSessionManager *manager = [RequestManager defaultNetManager];
        NSString *url=[@"" stringByAppendingString:@""];
        
        [manager POST:url parameters:Parameters constructingBodyWithBlock:
         ^(id<AFMultipartFormData>  _Nonnull formData) {
             [formData appendPartWithFileURL:Suburl
                                        name:@"audio" fileName:@"audio.wav" mimeType:@"audio/wav" error:nil];
         } progress:^(NSProgress * _Nonnull uploadProgress) {
             //             NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSString *reslut;
             NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *Dic=[Tools deleteAllNull:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
             reslut=[Tools dictionaryToJson:Dic];
             //ACDebug(@"res=%@",reslut);
             Block(nil,reslut,nil,nil);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (error.code == -1001) {
                 if (View!=nil) {
                     
                 }
             }else if(error.code == -1011){
                 if (View!=nil) {
                     
                 }
             }else{
                 
             }
             Block(nil,nil,error,nil);
         }];
    }else {
        if (View!=nil) {
            
        }
        Block(nil,nil,nil,@"noNet");
    }
}

//图片上传
+ (void)getJSON:(NSString*)url
      ImageData:(NSData*)imageData
       delegate:(id) delegate
       fileName:(NSString*)fileName
           type:(NSString*)type
didFinishSelector:(SEL)selector
didFailSelector:(SEL)selector2
didProgressBlockSelector:(SEL)selector3;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //多图
        //        for (NSData *imageData in imageDatas) {
        //
        //            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //
        //            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
        //
        //            NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
        //
        //            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"uploadFile%@",@(imgCount)] fileName:fileName mimeType:@"image/png"];
        //
        //            imgCount++;
        //
        //        }
        
        //上传文件参数
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:type];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //上传进度
        float progress = 1.00 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        if (delegate) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:selector3 withObject:[NSNumber numberWithFloat:progress]];
#pragma clang diagnostic pop
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic=[Tools deleteAllNull:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        
        NSInteger code = [[dic objectForKey:@"code"] integerValue];
        NSString *message = [dic objectForKey:@"message"];
        
        if (code == 200) {
            
            if (delegate) {
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [delegate performSelector:selector withObject:dic];
#pragma clang diagnostic pop
                
            }
        }else {
            
            if (delegate) {
                DLog(@"====error:%@",message);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [delegate performSelector:selector2 withObject:message];
#pragma clang diagnostic pop
                
            }
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (delegate) {
            DLog(@"====error:%@",[error localizedDescription]);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:selector2 withObject:error];
#pragma clang diagnostic pop
            
        }
        
    }];
    
}




+(void)clearCookies{
    NSArray*array =  [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"",@""]]];
    for(NSHTTPCookie*cookie in array){
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie: cookie];
    }
}
@end
