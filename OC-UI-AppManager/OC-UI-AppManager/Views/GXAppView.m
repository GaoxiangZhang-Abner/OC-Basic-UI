//
//  GXAppView.m
//  OC-UI-AppManager
//
//  Created by Gaoxiang Zhang on 2020/10/29.
//

#import "GXAppView.h"
#import "GXApp.h"

// 类扩展(私有化view的控件)
@interface GXAppView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
- (IBAction)clickDownloadBtn:(UIButton *)sender;

@end

@implementation GXAppView

/// 封装类方法, 从xib创建GXAppView
+ (instancetype) appView {
    // 通过xib创建view
    // 1. 找到根目录
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    // 2.在根目录下查找xib(加密后是nib)文件
    GXAppView *appView = [[rootBundle loadNibNamed:@"GXAppView" owner:nil options:nil] lastObject];
    
    return appView;
}

- (void)setModel:(GXApp *)model {
    _model = model;
    
    self.iconImgView.image = [UIImage imageNamed:model.icon];
    self.nameLbl.text = model.name;
    
}


- (IBAction)clickDownloadBtn:(UIButton *)sender {
    // 1.禁用
    sender.enabled = false;
    
    // 2.下载提示框
    UILabel *msgLbl = [UILabel new];
    msgLbl.backgroundColor = [UIColor blackColor];
    msgLbl.alpha = 0.0;
    
    CGFloat msgW = 200;
    CGFloat msgH = 30;
    CGFloat msgX = (self.superview.frame.size.width - msgW) * 0.5;
    CGFloat msgY = (self.superview.frame.size.height - msgH) * 0.5;
    msgLbl.frame = CGRectMake(msgX, msgY, msgW, msgH);
    
    msgLbl.text = @"正在下载...";
    msgLbl.textColor = [UIColor redColor];
    msgLbl.font = [UIFont boldSystemFontOfSize:17];
    msgLbl.textAlignment = NSTextAlignmentCenter;
    
    msgLbl.layer.cornerRadius = 10;
    msgLbl.layer.masksToBounds = true;
    
    [self.superview addSubview:msgLbl];
    
    [UIView animateWithDuration:1.0 animations:^{
        msgLbl.alpha = 0.6;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateKeyframesWithDuration:1.5 delay:1.0 options:UIViewAnimationCurveLinear animations:^{
                msgLbl.alpha = 0.0;
            } completion:^(BOOL finished) {
                if (finished) {
                    // 完全透明后移除提示信息
                    [msgLbl removeFromSuperview];
                }
            }];
        }
    }];
    
}
@end
