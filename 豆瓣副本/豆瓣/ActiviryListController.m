//
//  ActiviryListController.m
//  豆瓣
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//


#define kIdentifier @"ActivityCell"
#define KDefaultURL @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/activitylist.php"


#import "ActiviryListController.h"

#import "MyHelp.h"
#import "Activity.h"
#import "ActivityCell.h"
#import "ActivityDetailController.h"



@interface ActiviryListController ()

@property (nonatomic, strong) NSMutableArray *allActivities;

@end

@implementation ActiviryListController

#pragma mark 加载数据
- (void)loadData {
    
    if (self.allActivities == nil) {
        self.allActivities = [NSMutableArray array];
    }
    
    // 1、准备 URL
    NSURL *url = [NSURL URLWithString:KDefaultURL];
    // 2、准备请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    // 3、准备数据并解析
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [dict[@"events"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            // 创建 Activity 对象
            Activity *act = [[Activity alloc] init];
            // 使用 KVC 方式赋值
            [act setValuesForKeysWithDictionary:obj];
            // 将对象添加到数组中
            [self.allActivities addObject:act];
        }];
        // 因为是异步加载，数据的加载需要一定的时间，因此需要重新刷新一下，将数据显示出来
        // 因为页面的 cell 的加载非常快，但是数据还没有加载完毕，如果不刷新的话，数据不会显示在 cell 上
        [self.tableView reloadData];
    }];
}

#pragma mark 设置视图
- (void)setupView {
    // 设置导航栏
    self.navigationItem.title = @"活动";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    
    // 注册 xib
    [self.tableView registerNib:[UINib nibWithNibName:kIdentifier bundle:nil] forCellReuseIdentifier:kIdentifier];
    // 设置 tableView 的分割线不显示
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置行高, xib定义的大小就为222,如果要更改该值,也需要更改xib的高度
    self.tableView.rowHeight = 222.0f;
    
    // 显示进度
    [MyHelp showProgress:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置视图
    [self setupView];
    
    // 加载数据
    [self loadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allActivities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier forIndexPath:indexPath];
    
    // 取出对应的 Activity
    Activity *act = self.allActivities[indexPath.row];
    // 显示数据
    [cell showData:act];
    
    return cell;
}

#pragma mark 当一行被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityDetailController *detailController = [[ActivityDetailController alloc] init];
    // 属性传值,传递到下一个页面
    detailController.activity = self.allActivities[indexPath.row];    
    [self.navigationController pushViewController:detailController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end