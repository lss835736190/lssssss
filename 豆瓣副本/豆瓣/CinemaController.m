//
//  CinemaController.m
//  豆瓣
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//


#define kDefaultRowHeight 100
#define kIdentifier @"CinemaCell"
#define kDefaultURL @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/cinemalist.php"



#import "CinemaController.h"

#import "Cinema.h"
#import "CinemaCell.h"
#import "MyHelp.h"

@interface CinemaController ()

@property (nonatomic, strong) NSMutableArray *allCinemas;

@property (nonatomic, assign) CGFloat currentRowHeight;

@end

@implementation CinemaController

- (void)setupView {
    self.navigationItem.title = @"影院";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置行不会被选中
    self.tableView.allowsSelection = NO;
    // 去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置行高
//    self.tableView.rowHeight = kDefaultRowHeight;
    
    // 注册 cell
    [self.tableView registerClass:[CinemaCell class] forCellReuseIdentifier:kIdentifier];
}

#pragma mark 加载数据
- (void)loadData {
    if (self.allCinemas == nil) {
        self.allCinemas = [NSMutableArray array];
    }
    
    NSURL *url = [NSURL URLWithString:kDefaultURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [dict[@"result"][@"data"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Cinema *cinema = [[Cinema alloc] init];
            [cinema setValuesForKeysWithDictionary:obj];
            [self.allCinemas addObject:cinema];
        }];
        [self.tableView reloadData];
    }];
    
    [MyHelp showProgress:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置界面
    [self setupView];
    // 加载数据
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allCinemas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier forIndexPath:indexPath];
    
    Cinema *cinema = self.allCinemas[indexPath.row];
    
    CGFloat height = [self heightForAddress:cinema.address];
    
    CGRect addressLabelRect = cell.addressLabel.frame;
    addressLabelRect.size.height = height;
    cell.addressLabel.frame = addressLabelRect;
    [cell showData:cinema];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Cinema *cinema = self.allCinemas[indexPath.row];
    // 100为除了地址标签之外部分的总高度
    return 100 + [self heightForAddress:cinema.address];
}

#pragma mark 计算地址文字所占的高度
- (CGFloat)heightForAddress:(NSString *)address {
    
    return [address boundingRectWithSize:CGSizeMake(335, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
}


@end
