//
//  ViewController.m
//  OC-UI-Transform
//
//  Created by Gaoxiang Zhang on 2020/10/27.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *transformedBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)move:(id)sender {
    // 基于原始位置, 只移动一次
    // self.transformedBtn.transform = CGAffineTransformMakeTranslation(0, -50);
    
    // 基于移动前位置移动, 可以叠加移动
    self.transformedBtn.transform = CGAffineTransformTranslate(self.transformedBtn.transform, 0, -50);
    
}

- (IBAction)scale:(id)sender {
    // 一次性缩放
    // self.transformedBtn.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    // 叠加缩放
    self.transformedBtn.transform = CGAffineTransformScale(self.transformedBtn.transform, 2, 2);
    
}

- (IBAction)rotate:(id)sender {
    
    // ⚠️ 这里是弧度制
    // 2pi = 360度
    // M_PI_4 = PI/4 = 180/4 = 45度
    self.transformedBtn.transform = CGAffineTransformRotate(self.transformedBtn.transform, M_PI_2);
}

@end
