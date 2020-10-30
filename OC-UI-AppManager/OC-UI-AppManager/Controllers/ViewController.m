//
//  ViewController.m
//  OC-UI-AppManager
//
//  Created by Gaoxiang Zhang on 2020/10/29.
//

#import "ViewController.h"
#import "GXApp.h"
#import "GXAppView.h"

@interface ViewController ()



@property(nonatomic, strong) NSArray *apps;

@end

@implementation ViewController

// 懒加载app.plist数据
- (NSArray *)apps {
    
    if (_apps == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"app" ofType:@"plist"];
        NSArray *arrayDic = [NSArray arrayWithContentsOfFile:path];
        
        // 字典转模型
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dic in arrayDic) {
            GXApp *app = [GXApp initWithDict:dic];
            [arrayModels addObject:app];
        }
        
        _apps = arrayModels;
        
    }
    
    return _apps;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 基本数据
    int columns = 3; // 每行个数
    CGFloat marginTop = 100;
    CGFloat appW = 75;
    CGFloat appH = 90;
    
    // 循环创建appView
    for (int i = 0; i < self.apps.count ; i++) {
        
        GXApp *appModel = self.apps[i];
        
        // 1.通过xib创建view
        GXAppView *appView = [GXAppView appView];
        
        // 2.计算appView的位置
        CGFloat appMargin = (self.view.frame.size.width - appW * columns) / (columns + 1);
        CGFloat columnIdx = i % columns;
        CGFloat rowIdx = i / columns;
        CGFloat appX = appMargin * (columnIdx + 1) + appW * columnIdx;
        CGFloat appY = marginTop + (appMargin + appH) * rowIdx;
        appView.frame = CGRectMake(appX, appY, appW, appH);
        
        // 3.将appView加到父控件
        [self.view addSubview:appView];
        
        // 4.设置appView中的子控件的数据
        appView.model = appModel;
//        appView.iconImgView.image = [UIImage imageNamed:appModel.icon];
//        appView.nameLbl.text = appModel.name;
        
    }
    
}

@end


/**
 // ------------- 动态创建子控件代码 ----------------
 
 // 1.创建一个UIView
 UIView *appView = [UIView new];
 
 // 2.增加color和frame
 // appView.backgroundColor = [UIColor blueColor];
 CGFloat appMargin = (self.view.frame.size.width - appW * columns) / (columns + 1);
 CGFloat columnIdx = i % columns;
 CGFloat rowIdx = i / columns;
 CGFloat appX = appMargin * (columnIdx + 1) + appW * columnIdx;
 CGFloat appY = marginTop + (appMargin + appH) * rowIdx;
 appView.frame = CGRectMake(appX, appY, appW, appH);
 
 // 3.加到父视图
 [self.view addSubview:appView];
 
 // 4.添加子视图到appView
 // 4.1 添加icon
 CGFloat iconW = 45;
 CGFloat iconH = iconW;
 CGFloat iconX = (appView.frame.size.width - iconW) * 0.5;
 CGFloat iconY = 0;
 
 UIImageView *imgIconView = [UIImageView new];
 imgIconView.backgroundColor = [UIColor yellowColor];
 imgIconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
 imgIconView.image = [UIImage imageNamed:app.icon];
 [appView addSubview:imgIconView];
 
 // 4.2 添加app名
 CGFloat nameW = appView.frame.size.width;
 CGFloat nameH = 20;
 CGFloat nameX = 0;
 CGFloat nameY = iconH;
 
 UILabel *nameLbl = [UILabel new];
 // nameLbl.backgroundColor = [UIColor redColor];
 nameLbl.frame = CGRectMake(nameX, nameY, nameW, nameH);
 nameLbl.text = app.name;
 nameLbl.textAlignment = NSTextAlignmentCenter;
 nameLbl.font = [UIFont systemFontOfSize:12];
 [appView addSubview:nameLbl];
 
 
 // 4.3 添加按钮
 CGFloat btnW = iconW;
 CGFloat btnH = 20;
 CGFloat btnX = iconX;
 // CGFloat btnY = iconH + nameH;
 CGFloat btnY = CGRectGetMaxY(nameLbl.frame);
 
 UIButton *downloadBtn = [UIButton new];
 // downloadBtn.backgroundColor = [UIColor greenColor];
 downloadBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
 
 [downloadBtn setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
 [downloadBtn setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
 [downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
 [downloadBtn setTitle:@"已安装" forState:UIControlStateDisabled];
 downloadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
 [appView addSubview:downloadBtn];
 
 // 为按钮注册一个点击事件
 [downloadBtn addTarget:self action:@selector(clickdownloadBtn) forControlEvents:UIControlEventTouchUpInside];
 
 */
