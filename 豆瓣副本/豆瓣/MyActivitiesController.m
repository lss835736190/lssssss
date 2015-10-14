//
//  MyActivitiesController.m
//  豆瓣
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "MyActivitiesController.h"


#import "MyHelp.h"
#import "ActivityDetailController.h"
#import "UserEntry.h"
#import "LoginController.h"
#import "DataBaseHandler.h"
#import "Activity.h"


@interface MyActivitiesController ()

// 存储所有的活动,点击cell时可以传递过去
@property (nonatomic, strong) NSMutableArray *allCollectActivities;

@end

@implementation MyActivitiesController

#pragma mark 加载数据
- (void)p_loadData {
    
    // 存储活动的详细信息
    if (self.allCollectActivities == nil) {
        self.allCollectActivities = [NSMutableArray array];
    }
    
    // 打开数据库
    [[DataBaseHandler sharedDataBase] openDataBase];
    // 获取数据,并将其存储起来
    [self.allCollectActivities addObjectsFromArray:[[DataBaseHandler sharedDataBase] selectAllActivities]];
    // 关闭数据库
    [[DataBaseHandler sharedDataBase] closeDataBase];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"活动收藏";
    
    // 加载数据
    [self p_loadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allCollectActivities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.allCollectActivities[indexPath.row] title];
    
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 取出当前对象
        Activity *activity = self.allCollectActivities[indexPath.row];
        [[DataBaseHandler sharedDataBase] openDataBase];
        [[DataBaseHandler sharedDataBase] deleteActivityByID:activity.ID];
        [[DataBaseHandler sharedDataBase] closeDataBase];
        [self.allCollectActivities removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark 更改删除按钮上的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        ActivityDetailController *actController = [[ActivityDetailController alloc] init];
        actController.activity = self.allCollectActivities[indexPath.row];
        [self.navigationController pushViewController:actController animated:YES];
}

#pragma mark 设置行可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

#pragma mark 设置行的编辑模式是删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
