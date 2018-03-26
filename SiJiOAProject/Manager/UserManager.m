//
//  UserManager.m
//  SiJiOAProject
//
//  Created by qiong on 2018/3/7.
//  Copyright © 2018年 qiong. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
SINGLETON_FOR_CLASS(UserManager);
-(id)init
{
    if (self == [super init]) {
        _curUserInfo = [[UserModel alloc]init];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        _curUserInfo.userid = [[ud objectForKey:@"userID"] longLongValue];
    }
    return self;
}
-(void)setCurUserInfo:(UserModel *)curUserInfo;
{
    _curUserInfo = curUserInfo;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    
    [ud synchronize];
    
}
-(void)logout
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:nil forKey:@""];
    [ud synchronize];
}
@end
