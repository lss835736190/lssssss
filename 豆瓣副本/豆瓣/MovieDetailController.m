//
//  MovieDetailController.m
//  豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#define kIdentifier @"MovieDetailView"
#define kDefaultURL @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/searchmovie.php?movieId="


#import "MovieDetailController.h"

#import "MovieDetailView.h"
#import "MovieDetail.h"
#import "MyHelp.h"
#import "UserEntry.h"
#import "LoginController.h"
#import "DataBaseHandler.h"


@interface MovieDetailController ()

// 记录alertView,因为它需要自动消失
@property (nonatomic, strong) UIAlertView *alert;

@end

@implementation MovieDetailController

- (void)loadView {
    
    // 加载xib,作为controller的主视图
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:kIdentifier owner:nil options:nil];
    MovieDetailView *detailView = arr.lastObject;
    detailView.showsVerticalScrollIndicator = NO;
    self.view = detailView;
}

#pragma mark 加载数据并解析
- (void)loadData {
    
    /*
     当是从收藏界面转过来时,movieId是空的,因为它传递过来的是movieDetail
     当传的是movieDetail时,直接显示在View上即可
     */
    if (self.movieId == nil) {
        [((MovieDetailView *)self.view) showData:self.movieDetail];
        return;
    }
    
    //////////////// 如果是上个页面传递过来的movieId,需要进行网络请求 ////////////
    
    // 准备 URL
    NSURL *url = [NSURL URLWithString:[kDefaultURL stringByAppendingString:self.movieId]];
    // 准备请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // 请求数据并解析
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 开始解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        MovieDetail *detail = [[MovieDetail alloc] init];
        [detail setValuesForKeysWithDictionary:dict[@"result"]];
        // 解析完之后立即显示出来
        [((MovieDetailView *)self.view) showData:detail];
        self.navigationItem.title = detail.title;
        // 记录一下解析出来的数据
        self.movieDetail = detail;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backed:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_share.png"] style:UIBarButtonItemStyleDone target:self action:@selector(collected:)];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // 加载数据
    [self loadData];
    
    [MyHelp showProgress:self.view];
}

#pragma mark - 导航栏按钮点击事件
#pragma mark 返回
- (void)backed:(UIBarButtonItem *)item {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 对收藏行为做处理 -
- (void)p_dealWithCollectionBehaviour {
    
    /*
     这个过程中,打开数据库,做完处理之后,要立即关闭数据库
     如果已经收藏了,给出提示信息
     如果还没有收藏,首先进行收藏,然后给出提示信息
     */
    
    // 打开数据库
    [[DataBaseHandler sharedDataBase] openDataBase];
    // 判断电影是否已经被收藏    
    
    if ([[DataBaseHandler sharedDataBase] selectMovieByID:self.movieDetail.ID]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该活动已经收藏过" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        // 活动还没有被收藏,需要收藏的情况
        // 存入数据库
        [[DataBaseHandler sharedDataBase] insertMovie:self.movieDetail];
        // 显示提示信息
        [self p_createAlertView];
    }
    // 关闭数据库
    [[DataBaseHandler sharedDataBase] closeDataBase];
}

#pragma mark 收藏
- (void)collected:(UIBarButtonItem *)item {
    
    // 如果登录了,对收藏情况进行处理,如果没有登录,需要去登录
    if ([UserEntry sharedUser].isLogin) {
        [self p_dealWithCollectionBehaviour];
    } else {
        LoginController *loginController = [[LoginController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginController];
        [self.navigationController presentViewController:navController animated:YES completion:^{}];
        // 根据登录是否成功的情况做处理,登录状态会从下个页面block传值上来
        loginController.changeStatus = ^(BOOL status) {
            if (status == YES) {
                [UserEntry sharedUser].status = status;
                [self p_dealWithCollectionBehaviour];
            }
        };
    }
}

#pragma mark - 创建alertView
- (void)p_createAlertView {
    
    _alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(dismissAlertView) userInfo:nil repeats:NO];
    [_alert show];
}

#pragma mark 触发alertView消失
- (void)dismissAlertView {
    
    [_alert dismissWithClickedButtonIndex:0 animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
