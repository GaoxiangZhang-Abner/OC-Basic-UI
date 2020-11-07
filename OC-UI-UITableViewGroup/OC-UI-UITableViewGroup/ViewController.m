//
//  ViewController.m
//  OC-UI-UITableViewGroup
//
//  Created by Gaoxiang Zhang on 2020/11/7.
//

#import "ViewController.h"
#import "GXCarBrand.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *brands;

@end

@implementation ViewController

// 重写get方法
- (NSArray *)brands {

    // 懒加载Model
    if (_brands == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_simple" ofType:@"plist"];
        NSArray *arrayDict = [[NSArray alloc] initWithContentsOfFile: path];
        NSMutableArray *arrayModel = [NSMutableArray new];
        for (NSDictionary *dict in arrayDict) {
            GXCarBrand *model = [GXCarBrand carBrandWithDict:dict];
            [arrayModel addObject:model];
        }
        _brands = arrayModel;
    }
    
    return _brands;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];

}

#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.brands.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GXCarBrand *model = self.brands[section];
    return model.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    GXCarBrand *model = self.brands[indexPath.section];
    cell.textLabel.text = model.cars[indexPath.row];
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    GXCarBrand *model = self.brands[section];
    return model.title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    GXCarBrand *model = self.brands[section];
    return model.desc;
}

#pragma mark - 代理方法


@end
