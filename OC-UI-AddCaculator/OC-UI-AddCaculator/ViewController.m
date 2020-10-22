//
//  ViewController.m
//  OC-UI-AddCaculator
//
//  Created by Gaoxiang Zhang on 2020/10/21.
//

#import "ViewController.h"

@interface ViewController ()

// 第一个输入框
@property (weak, nonatomic) IBOutlet UITextField *txtNum1;

// 第二个输入框
@property (weak, nonatomic) IBOutlet UITextField *txtNum2;

// 结果显示
@property (weak, nonatomic) IBOutlet UILabel *txtResult;

// 计算方法
- (IBAction)compute:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)compute:(id)sender {
    
    // 1.获取两个输入的数字
    int num1 = self.txtNum1.text.intValue;
    int num2 = self.txtNum2.text.intValue;
    
    // 2.计算结果
    int resultNum = num1 + num2;
    
    // 3.显示数字
    self.txtResult.text = [NSString stringWithFormat:@"%d", resultNum];
    
    // 4.回收键盘方法一
//    [self.txtNum1 resignFirstResponder];
//    [self.txtNum2 resignFirstResponder];
    
    // 4.回收键盘方法二
    [self.view endEditing:YES];
}
@end
