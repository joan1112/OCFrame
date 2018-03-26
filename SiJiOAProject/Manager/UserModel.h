//
//  UserModel.h
//  SiJiOAProject
//
//  Created by qiong on 2018/3/7.
//  Copyright © 2018年 qiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject



@property(nonatomic,assign)long long userid;//用户ID
@property (nonatomic,copy) NSString * idcard;//展示用的用户ID
@property (nonatomic,copy) NSString * photo;//头像
@property (nonatomic,copy) NSString * nickname;//昵称


@end
