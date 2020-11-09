//
//  ViewController.m
//  OC-UI-Groupon
//
//  Created by Gaoxiang Zhang on 2020/11/8.
//

#import "ViewController.h"
#import "GXGoods.h"
#import "GXGoodsCell.h"
#import "GXFooterView.h"
#import "GXHeaderView.h"

#define CELLID @"goods_cell"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, GXFooterViewDelegate>

@property (nonatomic, strong) NSMutableArray *goods;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

// 懒加载模型
- (NSMutableArray *)goods {
    
    if (_goods == nil) {
        // 加载plist
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tgs" ofType:@"plist"];
        NSArray *dictArray = [[NSArray alloc] initWithContentsOfFile:path];
        
        // 字典转model
        NSMutableArray *modelArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in dictArray) {
            GXGoods *model = [[GXGoods alloc] initWithDict:dict];
            [modelArray addObject:model];
        }
        
        // 返回modelArray
        _goods = modelArray;
    }
    
    return _goods;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
}

- (void)setUpUI {
    // 创建tableView
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // 创建footerView
    GXFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"GXFooterView" owner:nil options:nil] firstObject];
    footerView.delegate = self;
    self.tableView.tableFooterView = footerView;
    
    // 创建headerView
    GXHeaderView *headerView = [GXHeaderView headerView];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - tableView数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goods.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    // 加载模型
    GXGoods *model = self.goods[indexPath.row];
    
    // 通过xib创建cell (通过ID重用cell)
    // 创建模型封装到cell中
    GXGoodsCell *cell = [GXGoodsCell goodsCellWithTableView:tableView];
    
    // 装载cell
    // 加载模型封装到cell中
    // 将模型装载入各个控件的过程放入重写的setGoods方法中，实现可以随时更换cell，完成解藕
    cell.goods = model;
    
    // 返回cell
    return cell;
}

#pragma mark - tableView代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - footerView代理方法
- (void)footerViewUpdateDate:(GXFooterView *)footerView {
    
    // 创建模型
    GXGoods *model = [[GXGoods alloc] init];
    model.icon = @"2c97690e72365e38e3e2a95b934b8dd2";
    model.title = @"火锅店";
    model.price = @"999.9";
    model.buyCount = @"1";
    
    // 把模型加入数组
    [self.goods addObject:model];
    
    for (GXGoods *model in self.goods) {
        NSLog(@"%@", model.title);
    }
    
    // 刷新tableView (局部刷新只适用tableView行数没有变化)
    [self.tableView reloadData];
//    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.goods.count - 1 inSection:0];
//    [self.tableView reloadRowsAtIndexPaths:@[idxPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // 向上滚动，显示出完整的最后一行
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.goods.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:true];

}

@end
