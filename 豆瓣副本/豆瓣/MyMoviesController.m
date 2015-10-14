//
//  MyMoviesController.m
//  豆瓣
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import "MyMoviesController.h"

#import "MyHelp.h"
#import "MovieDetailController.h"
#import "DataBaseHandler.h"
#import "MovieDetail.h"

@interface MyMoviesController ()

// 记录所有收藏的电影的信息
@property (nonatomic, strong) NSMutableArray *allCollectMovies;

@end

@implementation MyMoviesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"电影收藏";
    
    if (self.allCollectMovies == nil) {
        self.allCollectMovies = [NSMutableArray array];
    }
    
    // 打开数据库
    [[DataBaseHandler sharedDataBase] openDataBase];
    // 读取数据并存储起来
    [self.allCollectMovies addObjectsFromArray:[[DataBaseHandler sharedDataBase] selectAllMovies]];
    // 关闭数据库
    [[DataBaseHandler sharedDataBase] closeDataBase];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allCollectMovies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.allCollectMovies[indexPath.row] title];
    
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MovieDetail *movieDatail = self.allCollectMovies[indexPath.row];
        [[DataBaseHandler sharedDataBase] openDataBase];
        [[DataBaseHandler sharedDataBase] deleteMovieByID:movieDatail.ID];
        [[DataBaseHandler sharedDataBase] closeDataBase];
        [self.allCollectMovies removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieDetailController *detailController = [[MovieDetailController alloc] init];
    detailController.movieDetail = self.allCollectMovies[indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

@end
