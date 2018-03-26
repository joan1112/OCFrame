//
//  MainViewController.m
//  SiJiOAProject
//
//  Created by qiong on 2018/3/7.
//  Copyright © 2018年 qiong. All rights reserved.
//

#import "MainViewController.h"
#import "ReportDetailViewController.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *headerTab;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 80;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headerTab;
    
}

//header
-(UIView*)headerTab
{
    if (_headerTab == nil) {
        _headerTab = [[UIView alloc]initWithFrame:CGRectMake(15, 0, KScreenWidth - 30, 120)];
        _headerTab.backgroundColor = [UIColor whiteColor];
    }
   
    
    
    return _headerTab;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark----tableDelegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"1234";
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 90)];
    head.backgroundColor = CViewBgColor;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, KScreenWidth, 45)];
    lab.backgroundColor = [UIColor whiteColor];
    lab.font = MainTitleFont;
    lab.textColor = MaintextColor;
    lab.text = @"   通告资讯";
    [head addSubview:lab];
    
    return head;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReportDetailViewController *detail = [[ReportDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
@end
