//
//  RootViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//


#define kTagStart 1000




#import "RootViewController.h"

#import "ActiviryListController.h"
#import "CinemaController.h"
#import "MyCollectionController.h"
#import "MovieShowController.h"
#import "MyHelp.h"
#import "UserEntry.h"
#import "DataBaseHandler.h"


@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 活动页面
    ActiviryListController *activityList = [[ActiviryListController alloc] initWithStyle:UITableViewStylePlain];
    activityList.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"活动" image:[UIImage imageNamed:@"activity.png"] tag:kTagStart];
    UINavigationController *activityNav = [[UINavigationController alloc] initWithRootViewController:activityList];
    
    // 电影页面    
    MovieShowController *movieController = [[MovieShowController alloc] init];
    movieController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"电影" image:[UIImage imageNamed:@"cinema.png"] tag: kTagStart + 1];
    UINavigationController *movieNav = [[UINavigationController alloc] initWithRootViewController:movieController];
    
    // 影院页面
    CinemaController *cinemaList = [[CinemaController alloc] initWithStyle:UITableViewStylePlain];
    cinemaList.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"影院" image:[UIImage imageNamed:@"cinema.png"] tag: kTagStart + 2];
    UINavigationController *cinemaNav = [[UINavigationController alloc] initWithRootViewController:cinemaList];
    
    // 我的页面
    MyCollectionController *myCollection = [[MyCollectionController alloc] initWithStyle:UITableViewStylePlain];
    myCollection.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"user.png"] tag: kTagStart + 3];
    UINavigationController *myCollectionNav = [[UINavigationController alloc] initWithRootViewController:myCollection];
    
    self.viewControllers = @[activityNav, movieNav, cinemaNav, myCollectionNav];
    
    // 在程序的一开始就创建数据库,以及数据库中的表
    [[DataBaseHandler sharedDataBase] openDataBase];
    [[DataBaseHandler sharedDataBase] createActivityTable];
    [[DataBaseHandler sharedDataBase] createMovieTable];
    [[DataBaseHandler sharedDataBase] createUserTable];
    [[DataBaseHandler sharedDataBase] closeDataBase];
    
    // 初始情况下,默认用户是没有登录的
    [UserEntry sharedUser].status = NO;
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
