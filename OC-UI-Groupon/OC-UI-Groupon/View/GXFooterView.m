//
//  GXFooterView.m
//  OC-UI-Groupon
//
//  Created by Gaoxiang Zhang on 2020/11/9.
//

#import "GXFooterView.h"

@interface GXFooterView ()

@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIButton *loadMoreBtn;

@end

@implementation GXFooterView

- (IBAction)loadMoreInfo:(id)sender {
    
    // 隐藏加载更多按钮
    self.loadMoreBtn.hidden = true;
    
    // 显示加载视图
    self.loadingView.hidden = false;
    
    // 执行后延迟1秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 利用代理，让Controller加载数据
        // 确保代理方法被实现了，否则不掉用
        if ([self.delegate respondsToSelector:@selector(footerViewUpdateDate:)]) {
            [self.delegate footerViewUpdateDate:self];
        }
        
        // 隐藏加载视图
        self.loadingView.hidden = true;
        
        // 显示加载更多按钮
        self.loadMoreBtn.hidden = false;
    });


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
