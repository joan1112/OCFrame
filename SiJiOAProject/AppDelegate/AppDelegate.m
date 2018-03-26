//
//  AppDelegate.m
//  SiJiOAProject
//
//  Created by qiong on 2018/2/23.
//  Copyright © 2018年 qiong. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "LoginViewController.h"
#import "BaseTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    BaseTabBarController *vc = [[BaseTabBarController alloc]init];
    
    int A=65;
    int i;
    for(i=1;i<=26;i++){
        printf("%c\n",A);
        A++;
    }
    self.window.rootViewController = vc;
   
    [self.window makeKeyAndVisible];
    
    NSLog(@"%f",[UIDevice currentDevice].systemVersion.floatValue);
    return YES;
}

-(void)setKeyboardHiden
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    // 控制点击背景是否收起键盘
    keyboardManager.shouldResignOnTouchOutside = YES;
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES;
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = YES;
    // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17];
    // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    
    
   
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)showAlert:(NSString *)title{
    if (title!=nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:title
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定",nil];
        [alert show];
    }
}

//MBProgressHUD显示
-(void)MBhudShow :(UIView *)currentView :(NSString *)txt{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:currentView animated:YES];
        hud.label.text=txt;
        hud.alpha=0.7;
    });
}

//MBProgressHUD隐藏
-(void)MBhudHide :(UIView *)currentView{
    [MBProgressHUD hideHUDForView:currentView animated:YES];
}

-(void)maketoast :(NSString *)title :(UIView *)currentView{
    [currentView makeToast:title
                  duration:1.0
                  position:CSToastPositionCenter];
}

@end
