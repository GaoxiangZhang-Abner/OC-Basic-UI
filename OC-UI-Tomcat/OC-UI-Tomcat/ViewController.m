//
//  ViewController.m
//  OC-UI-Tomcat
//
//  Created by Gaoxiang Zhang on 2020/10/28.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)drink:(id)sender {
    
    // 1.获取动画图片数组
    NSMutableArray *arrayM = [NSMutableArray new];
    
    for (int i = 0; i < 81; i++) {
        NSString *imageName = [NSString stringWithFormat:@"drink_%02d.jpg", i];
        
        // 此方法加载的图片运行完成不会被释放
        // 优点：再次执行drink方法不用加载图片
        // 缺点：占用内存(缓存)
        // UIImage *image = [UIImage imageNamed:imageName];
        
        // 无缓存的加载图片方法: path
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        [arrayM addObject:image];

    }
    
    // 2.加入animationImages数组
    self.imageView.animationImages = arrayM;
    
    // 3.设置动画时长
    self.imageView.animationDuration = arrayM.count * 0.1;
    
    // 4.设置重复次数
    self.imageView.animationRepeatCount = 1;
    
    // 5.播放动画
    [self.imageView startAnimating];
    
    // 6.清空存储的动画图片(延迟调用setAnimationImages方法)
    [self.imageView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:arrayM.count * 0.1];
    
}

/// 打招呼方式
/// @param name 姓名
/// @param age 年龄
- (void)sayHi:(NSString *)name AndWithAge:(int)age {
    NSLog(@"按住command+alt+/, 生成文档注释");
}

@end
