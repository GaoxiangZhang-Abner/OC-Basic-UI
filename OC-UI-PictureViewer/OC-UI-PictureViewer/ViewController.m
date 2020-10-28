//
//  ViewController.m
//  OC-UI-PictureViewer
//
//  Created by Gaoxiang Zhang on 2020/10/28.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet UILabel *indexLbl;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (nonatomic, strong) NSArray* pic;
@property (nonatomic, assign) int index;

@end

@implementation ViewController

// 重写pic的get方法
// ------------------- 懒加载数据 -------------------
- (NSArray *)pic {
    
    // 懒加载
    if (_pic == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pic" ofType:@"plist"];
        _pic = [NSArray arrayWithContentsOfFile:path];
    }
    return _pic;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 让索引前一页, 再执行next方法走到第一个图片
    self.index = -1;
    [self next];

}

- (void) setUpPicViewer {
    NSDictionary *firstPicDic = self.pic[0];
    NSString *icon = firstPicDic[@"icon"];
    NSString *description = firstPicDic[@"description"];
    
    self.imageView.image = [UIImage imageNamed:icon];
    self.descriptionLbl.text = description;
    self.indexLbl.text = [NSString stringWithFormat:@"%d/%ld", 1, self.pic.count];
}

- (IBAction)next {

    // 1.索引+1
    self.index++;
    
    [self setUpPreAndNextBtn];
    
}

- (IBAction)pre {
        
    // 1.索引-1
    self.index--;
    
    [self setUpPreAndNextBtn];
    
}

- (void)setUpPreAndNextBtn {
    // 2.从数组获取对应的图片名和描述
    NSDictionary *dic = self.pic[self.index];
    NSString *icon = dic[@"icon"];
    NSString *description = dic[@"description"];
    
    // 3.赋值
    self.imageView.image = [UIImage imageNamed:icon];
    self.descriptionLbl.text = description;
    self.indexLbl.text = [NSString stringWithFormat:@"%d/%ld", self.index + 1, self.pic.count];
    
    // 4.提前禁用按钮
    self.leftBtn.enabled = (self.index != 0);
    self.rightBtn.enabled = (self.index + 1 != self.pic.count); // self.index + 1 = 下一个图片的索引
}

@end
