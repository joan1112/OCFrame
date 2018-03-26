//
//  AppDelegate.h
//  SiJiOAProject
//
//  Created by qiong on 2018/2/23.
//  Copyright © 2018年 qiong. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,assign)BOOL netWork;

-(void)showAlert:(NSString *)title;
-(void)MBhudShow :(UIView *)currentView :(NSString *)txt;
-(void)MBhudHide :(UIView *)currentView;
-(void)maketoast :(NSString *)title :(UIView *)currentView;
@end

