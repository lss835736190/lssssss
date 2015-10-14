
//
//  MovieShowController.m
//  豆瓣
//
//  Created by lanou3g on 15/9/20.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//


#define kRowHeight 140
#define kListCellIdentifier @"MovieCell"
#define kDefaultURL @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/movielist.php"

#define kScreenWidth 356
#define kDefaultItems 3
#define kCollectionCellIdentifier @"CollectionCell"



#import "MovieShowController.h"

#import "Movie.h"
#import "MovieCell.h"
#import "MovieDetailController.h"
#import "MyHelp.h"
#import "MovieCollectionView.h"
#import "MovieCollectionCell.h"

@interface MovieShowController ()

@property (nonatomic, strong) NSMutableArray *allMovies;

@end

@implementation MovieShowController

#pragma mark 设置界面
- (void)setupView {
    
    // 关于导航条上的一些信息的设置
    self.navigationItem.title = @"电影";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_list@2x.png"] style:UIBarButtonItemStyleDone target:self action:@selector(changeStyle:)];
    // 设置前景色为黑色
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // 创建tableView
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    // 设置分割线不显示
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置行高
    self.tableView.rowHeight = kRowHeight;
    // 注册 xib
    [self.tableView registerNib:[UINib nibWithNibName:kListCellIdentifier bundle:nil] forCellReuseIdentifier:kListCellIdentifier];
    // 设置tableView的代理和数据源
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 创建collectionView
    UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc] init];
    layoutView.minimumLineSpacing = 20;
    layoutView.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layoutView.itemSize = CGSizeMake(100, 160);
    self.collectionView = [[MovieCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layoutView];
    // 设置collectionView的代理和数据源
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    // 注册collectionCell
    [self.collectionView registerClass:[MovieCollectionCell class] forCellWithReuseIdentifier:kCollectionCellIdentifier];
    
    // 应该先添加collectionView,后添加tableView,这样就先显示的是tableView
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.tableView];
    
    // 显示小菊花
    [MyHelp showProgress:self.view];
}


#pragma mark 导航栏按钮点击触发
- (void)changeStyle:(UIBarButtonItem *)item {
    if (item.tag == 0) {
        [UIView transitionFromView:self.tableView toView:self.collectionView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"btn_nav_collection@2x.png"];
        }];
    } else {
        [UIView transitionFromView:self.collectionView toView:self.tableView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"btn_nav_list@2x.png"];
        }];
    }
    item.tag = !item.tag;
    // 由于转换之后右边按钮的前景色会发生改变,因此需要再重新设置一回
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

#pragma mark 加载数据
- (void)loadData {
    // 初始化数组
    if (self.allMovies == nil) {
        self.allMovies = [NSMutableArray array];
    }
    
    // 1、准备 URL
    NSURL *url = [NSURL URLWithString:kDefaultURL];
    // 2、准备请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // 3、准备数据并解析
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 开始解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [dict[@"result"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            // 初始化 Movie 对象
            Movie *movie = [[Movie alloc] init];
            // KVC 赋值
            [movie setValuesForKeysWithDictionary:obj];
            // 加入数组
            [self.allMovies addObject:movie];
        }];
        // 刷新界面
        [self.tableView reloadData];
        [self.collectionView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置界面
    [self setupView];
    // 加载数据
    [self loadData];
}

#pragma mark - Table view data source
#pragma mark 显示行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.allMovies.count;
}

#pragma mark 自定义 cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:kListCellIdentifier forIndexPath:indexPath];
    
    // 取出对应的 Movie 对象
    Movie *movie = self.allMovies[indexPath.row];
    // 将其显示在 cell 上
    [cell showData:movie];
    
    return cell;
}

#pragma mark - 当选中某一行时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self p_enterNextControllerWithRow:indexPath.row];
}

- (void)p_enterNextControllerWithRow:(NSUInteger)row {
    
    MovieDetailController *detailController = [[MovieDetailController alloc] init];
    detailController.movieId = [self.allMovies[row] movieId];
    [self.navigationController pushViewController:detailController animated:YES];
}


#pragma make - DataSource方法
#pragma mark 每行的项数

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.allMovies.count;
}

#pragma mark 每行显示的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIdentifier forIndexPath:indexPath];
    if (self.allMovies.count != 0) {
        // 取出对应的 Movie 对象
        Movie *movie = self.allMovies[indexPath.row];
        // 将其显示在 cell 上
        [cell showData:movie];
    }
    
    return cell;
}

#pragma mark 当选中某行时触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self p_enterNextControllerWithRow:indexPath.row];
}


- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
