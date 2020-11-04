//
//  ViewController.m
//  OC-UI-GuessPicture
//
//  Created by Gaoxiang Zhang on 2020/10/30.
//

#import "ViewController.h"
#import "GXQuestion.h"

@interface ViewController ()
@property (nonatomic, assign) int index;
@property (weak, nonatomic) IBOutlet UIButton *scoreBtn;
@property (weak, nonatomic) IBOutlet UILabel *indexLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) UIButton *coverBtn;
@property (nonatomic, assign) CGRect iconRect;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionView;
@property (weak, nonatomic) IBOutlet UIButton *tipBtn;
@property (nonatomic, strong) NSArray *questions;
@end

@implementation ViewController

/// 更改状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/// 懒加载模型数据
- (NSArray *)questions {
    if (_questions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
        NSArray *arrayDic = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        for (NSDictionary *dic in arrayDic) {
            GXQuestion *model = [GXQuestion questionWithDic:dic];
            [arrayModel addObject:model];
        }
        _questions = arrayModel;
    }
    
    return _questions;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化第一题
    self.index = -1;
    [self next];
}

/// 下一题
- (IBAction)next {
    
    // 索引自增
    self.index++;
    
    // 检查越界
    if (self.index == self.questions.count) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"操作提示" message:@"恭喜通关" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
           handler:^(UIAlertAction * action) {
            self.index = -1;
            [self next];
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    };
    
    // question
    GXQuestion *model = self.questions[self.index];
    
    // 控件填充模型数据
    [self makeDataWithModel:model];
    
    // 动态创建答案按钮
    [self makeAnswerBtnsWithModel:model];
    
    // 动态创建选项按钮
    [self makeOptionBtnsWithModel:model];
    
    // 边界检查禁用按钮
    self.nextBtn.enabled = (self.index != self.questions.count - 1);
        
}

/// 控件填充模型数据
/// @param model 数据模型
- (void) makeDataWithModel: (GXQuestion *)model {
    // indexLbl
    self.indexLbl.text = [NSString stringWithFormat:@"%d / %ld", self.index + 1, self.questions.count];
    
    // title
    self.titleLbl.text = model.title;
    
    // icon
    [self.iconBtn setImage:[UIImage imageNamed: model.icon] forState:UIControlStateNormal];
    
}

/// 动态创建答案按钮
/// @param model 数据模型
- (void) makeAnswerBtnsWithModel: (GXQuestion *)model {
    // 清除所有的答案按钮
    [self.answerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
    // 创建按钮
    NSInteger answerLength = model.answer.length;
    CGFloat margin = 10;
    CGFloat answerW = self.answerView.frame.size.height;
    CGFloat answerH = answerW;
    CGFloat answerY = 0;
    CGFloat marginLeft = (self.answerView.frame.size.width - answerW * answerLength - margin * (answerLength - 1)) * 0.5;
    
    for (int i = 0; i < answerLength; i++) {
        UIButton *answerBtn = [UIButton new];
        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        CGFloat answerX = marginLeft + (answerW + margin) * i;\
        answerBtn.frame = CGRectMake(answerX, answerY, answerW, answerH);
        [answerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [answerBtn addTarget:self action:@selector(returnAnswer:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.answerView addSubview:answerBtn];
    }
}

/// 动态创建选项按钮
/// @param model 数据模型
- (void)makeOptionBtnsWithModel: (GXQuestion *)model {
    
    // 清除所有的选项按钮
    [self.optionView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 恢复被禁用的选项按钮
    self.optionView.userInteractionEnabled = true;
    
    NSArray *options = model.options;
    int column = 7;
    CGFloat margin = 15;
    CGFloat optionViewW = self.optionView.frame.size.width;
    CGFloat optionW = 40;
    CGFloat optionH = optionW;
    CGFloat marginLeft = (optionViewW - optionW * column - margin * (column - 1)) * 0.5;
    for (int i = 0; i < options.count; i++) {
        UIButton *optionBtn = [UIButton new];
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
        [optionBtn setTitle:options[i] forState:UIControlStateNormal];
        [optionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        int indexX = i % column;
        int indexY = i / column;
        CGFloat optionX = marginLeft + (optionW + margin) * indexX;
        CGFloat optionY = (optionH + margin) * indexY;
        optionBtn.frame = CGRectMake(optionX, optionY, optionW, optionH);
        
        optionBtn.tag = i;
        [optionBtn addTarget:self action:@selector(chooseOption:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.optionView addSubview:optionBtn];
    }
    
}

/// 撤回答案
/// @param sender 答案按钮
- (void)returnAnswer: (UIButton *)sender {
    
    self.optionView.userInteractionEnabled = true;
    [self setAnswerBtnTitleColor: [UIColor blackColor]];
    
    for (UIButton* optionBtn in self.optionView.subviews) {
        if (sender.tag == optionBtn.tag) {
            [sender setTitle:nil forState:UIControlStateNormal];
            optionBtn.hidden = false;
        }
    }
}

/// 选择选项
/// @param sender 选项按钮
- (void)chooseOption: (UIButton *)sender {
    // 隐藏optionBtn
    sender.hidden = true;
    
    // option的内容给answer
    for (UIButton *answerBtn in self.answerView.subviews) {
        if (answerBtn.currentTitle == nil) {
            [answerBtn setTitle:sender.currentTitle forState:UIControlStateNormal];
            answerBtn.tag = sender.tag;
            break;
        }
    }
    
    NSMutableString *answer = [NSMutableString new];
    
    // answer填满后被禁用
    BOOL isFull = true;
    for (UIButton *answerBtn in self.answerView.subviews) {
        if (answerBtn.currentTitle == nil) {
            isFull = false;
        } else {
            [answer appendString:answerBtn.currentTitle];
        }
    }
    if (isFull) {
        self.optionView.userInteractionEnabled = false;
        GXQuestion *model = self.questions[self.index];
        NSString *rightAnswer = model.answer;
        if ([answer isEqualToString:rightAnswer]) {
            [self setAnswerBtnTitleColor: [UIColor blueColor]];
            [self performSelector:@selector(next) withObject:nil afterDelay:0.2];
            [self modifyScore:1000];
        } else {
            [self setAnswerBtnTitleColor: [UIColor redColor]];
            [self modifyScore:-1000];
        }
    }
}

- (void)setAnswerBtnTitleColor: (UIColor *)color {
    for (UIButton *answerBtn in self.answerView.subviews) {
        [answerBtn setTitleColor:color forState:UIControlStateNormal];
    }
}

/// 放大icon
/// @param sender icon
- (IBAction)amplifyIconBtn: (id)sender {
    
    // cover
    UIButton *coverBtn = [UIButton new];
    coverBtn.frame = self.view.frame;
    coverBtn.backgroundColor = [UIColor blackColor];
    coverBtn.alpha = 0.6;
    [self.view addSubview:coverBtn];
    
    self.coverBtn = coverBtn;
    [coverBtn addTarget:self action:@selector(reduceIconBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // icon
    [self.view bringSubviewToFront:self.iconBtn];
    self.iconBtn.enabled = false;
    self.iconRect = self.iconBtn.frame;
    
    CGFloat iconW = self.view.frame.size.width;
    CGFloat iconH = iconW;
    CGFloat iconX = 0;
    CGFloat iconY = (self.view.frame.size.height - iconH) * 0.5;
    [UIView animateWithDuration:1.0 animations:^{
        self.iconBtn.frame = CGRectMake(iconX, iconY, iconW, iconH);
    }];

}

/// 减少icon
- (void)reduceIconBtn {
    
    [UIView animateWithDuration:1.0 animations:^{
        // icon
        self.iconBtn.frame = self.iconRect;
        self.iconBtn.enabled = true;
        
        // cover
        self.coverBtn.alpha = 0.0;
    } completion:^(BOOL finished) {
        // 移除cover
        if (finished) {
            [self.coverBtn removeFromSuperview];
            self.coverBtn = nil;
        }
    }];

}

/// 加减分
- (void)modifyScore: (int)score {
    
    // 获取按钮现在的分值
    int currentScore = self.scoreBtn.currentTitle.intValue;
    
    // 加减分
    currentScore += score;
    
    // 新分数赋值给按钮
    [self.scoreBtn setTitle:[NSString stringWithFormat:@"%d", currentScore] forState:UIControlStateNormal];
    
}

/// 提示
/// @param sender 按钮
- (IBAction)giveTip:(id)sender {
    
    // 扣分
    [self modifyScore:-500];
    
    // 清空答案(触发每个答案按钮点击事件)
    for (UIButton *answerBtn in self.answerView.subviews) {
        [self returnAnswer:answerBtn];
    }
    
    // 寻找第一个正确的答案
    GXQuestion *model = self.questions[self.index];
    NSString *firstAnswer = [model.answer substringToIndex:1];
    for (UIButton *optionBtn in self.optionView.subviews) {
        if ([firstAnswer isEqualToString:optionBtn.currentTitle]) {
            [self chooseOption:optionBtn];
            break;
        }
    }
    
}


@end
