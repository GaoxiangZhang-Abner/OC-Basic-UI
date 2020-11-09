//
//  GXHeaderView.m
//  OC-UI-Groupon
//
//  Created by Gaoxiang Zhang on 2020/11/9.
//

#import "GXHeaderView.h"

@interface GXHeaderView ()

@property (weak, nonatomic) IBOutlet UIScrollView *scoreView;

@end

@implementation GXHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"GXHeaderView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    int imgN = 4;
    CGFloat imgW = self.scoreView.frame.size.width;
    CGFloat imgH = self.scoreView.frame.size.height;
    CGFloat imgY = 0;
    
    for (int i = 0; i < imgN; i++) {
    
        UIImageView *imgView = [[UIImageView alloc] init];
        
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ad_0%d",i]];
        
        CGFloat imgX = i * imgW;
        imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        
        [self.scoreView addSubview:imgView];
        
    }
    
    self.scoreView.contentSize = CGSizeMake(imgW * imgN, imgH);
    self.scoreView.showsHorizontalScrollIndicator = false;
//    self.scoreView.pagingEnabled = true;
    NSLog(@"%@", self.frame);
    NSLog(@"%@", self.scoreView.frame);

    
}

@end
