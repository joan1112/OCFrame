//
//  BaseNavigationController.h
//  SiJiOAProject
//
//  Created by qiong on 2018/2/23.
//  Copyright © 2018年 qiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController


-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;

@end
