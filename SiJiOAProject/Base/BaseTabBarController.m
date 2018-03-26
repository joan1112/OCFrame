//
//  BaseTabBarController.m
//  SiJiOAProject
//
//  Created by qiong on 2018/3/7.
//  Copyright © 2018年 qiong. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "BaseTabbar.h"
#import "MainViewController.h"
#import "ContactViewController.h"
#import "PersonalViewController.h"
@interface BaseTabBarController ()
@property (nonatomic,strong) NSMutableArray * VCS;//tabbar root VC

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTabBar];
    [self setUpAllChildViewController];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark ————— 初始化TabBar —————
-(void)setUpTabBar{
    //设置背景色 去掉分割线
    [self setValue:[BaseTabbar new] forKey:@"tabBar"];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    //通过这两个参数来调整badge位置
    //    [self.tabBar setTabIconWidth:29];
    //    [self.tabBar setBadgeTop:9];
}

-(void)setUpAllChildViewController{
    _VCS = [NSMutableArray array];
    MainViewController *main = [[MainViewController alloc]init];
    [self setupChildViewController:main title:@"工作" imageName:@"" seleceImageName:@""];
    
    ContactViewController *contact = [[ContactViewController alloc]init];
    [self setupChildViewController:contact title:@"通讯录" imageName:@"" seleceImageName:@""];
    
    PersonalViewController *person = [[PersonalViewController alloc]init];
    [self setupChildViewController:person title:@"我的" imageName:@"" seleceImageName:@""];
    
    self.viewControllers = _VCS;
}
-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KBlackColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateNormal];
    
    //选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MainThemeColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateSelected];
    //包装导航控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:controller];
    
    //    [self addChildViewController:nav];
    [_VCS addObject:nav];
    
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //    NSLog(@"选中 %ld",tabBarController.selectedIndex);
    
}

//-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow{
//    if (isShow) {
//        [self.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:0 atIndex:index];
//    }else{
//        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:0 atIndex:index];
//    }
//
//}

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
