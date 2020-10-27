//
//  ViewController.m
//  OC-UI-Button
//
//  Created by Gaoxiang Zhang on 2020/10/27.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *mainButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // MARK:- 纯代码创建按钮和按钮的方法
    // 1.创建按钮
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(self.view.frame.size.width / 2 - 50, 300, 100, 100);
    [self.view addSubview:button];
    
    // 2.设置按钮默认和高亮状态的背景
    [button setBackgroundImage:[UIImage imageNamed:@"btn_02"] forState: UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_01"] forState:UIControlStateHighlighted];
    
    // 3.设置按钮默认和高亮状态的文字
    [button setTitle:@"哈哈哈" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [button setTitle:@"动漫高手" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    // 4.设置按钮的点击事件 为Target对象的action方法来执行点击事件
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonClick {
    NSLog(@"点了我哈哈哈哈哈");
}

// ⚠️ 如果要修改一个结构体内的属性，需要先把结构体赋值再修改，不可直接修改
// 即不可以 self.mainButton.frame.origin.y += 10;

// 用frame, 根据sender.tag移动不同的方向
- (IBAction)move:(UIButton *)sender {
    
    CGRect mainButtonFrame = self.mainButton.frame;
    int moveDistance = 30;
    
    switch (sender.tag) {
        case 1:
            mainButtonFrame.origin.y -= moveDistance;
            break;
        case 2:
            mainButtonFrame.origin.y += moveDistance;
            break;
        case 3:
            mainButtonFrame.origin.x -= moveDistance;
            break;
        case 4:
            mainButtonFrame.origin.x += moveDistance;
            break;
        default:
            break;
    }
    
    // 额外：开启一个动画
    [UIView animateWithDuration:0.5 animations:^{
        self.mainButton.frame = mainButtonFrame;
    }];
    
}

// 用frame, 根据sender.tag改变大小
- (IBAction)changeSize:(UIButton *)sender {
    
    CGRect mainButtonFrame = self.mainButton.frame;
    int scale = 10;
    
    switch (sender.tag) {
        case 1:
            mainButtonFrame.size = CGSizeMake(mainButtonFrame.size.width + scale, mainButtonFrame.size.height + scale);
            break;
        case -1:
            mainButtonFrame.size = CGSizeMake(mainButtonFrame.size.width - scale, mainButtonFrame.size.height - scale);
            break;
        default:
            break;
    }
    
    // 额外：开启一个动画
    [UIView animateWithDuration:0.5 animations:^{
        self.mainButton.frame = mainButtonFrame;
    }];
    
}

// 通过center和bound移动位置和改变大小
- (IBAction)moveWithCenter:(UIButton *)sender {
    
    // ⚠️ center和frame的区别: center是图片的中心点坐标, frame是图片左上角的坐标
    CGPoint mainButtonCenter = self.mainButton.center;
    
    switch (sender.tag) {
        case 1:
            mainButtonCenter.y -= 10;
            break;
        case 2:
            mainButtonCenter.y += 10;
            break;
        case 3:
            mainButtonCenter.x -= 10;
            break;
        case 4:
            mainButtonCenter.x += 10;
            break;
        default:
            break;
    }
    
    self.mainButton.center = mainButtonCenter;
    
}

// 用bounds, 根据sender.tag改变大小, 与之前的区别(中心点不变, 围绕中心点变大)
// bounds：该view在本地坐标系统中的位置和大小。（参照点是，本地坐标系统，就相当于view自己的坐标系统，以0,0点为起点）
- (IBAction)changeSizeWithBound:(UIButton *)sender {
    
    
    CGRect mainButtonBound = self.mainButton.bounds;
    
    switch (sender.tag) {
        case 1:
            mainButtonBound
            .size = CGSizeMake(mainButtonBound.size.width + 10, mainButtonBound.size.height + 10);
            break;
        case -1:
            mainButtonBound.size = CGSizeMake(mainButtonBound.size.width - 10, mainButtonBound.size.height - 10);
            break;
        default:
            break;
    }
    
    self.mainButton.bounds = mainButtonBound;
}

@end
