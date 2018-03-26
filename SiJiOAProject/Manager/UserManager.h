//
//  UserManager.h
//  SiJiOAProject
//
//  Created by qiong on 2018/3/7.
//  Copyright © 2018年 qiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

#define curUser [UserManager sharedUserManager].curUserInfo
#define userManager [UserManager sharedUserManager]
@interface UserManager : NSObject
SINGLETON_FOR_HEADER(UserManager)

//当前用户
@property (nonatomic, strong) UserModel *curUserInfo;
@property (nonatomic, assign) BOOL isLogined;

-(void)setCurUserInfo:(UserModel *)curUserInfo;
-(void)logout;
@end
