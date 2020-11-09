//
//  GXGoodsCell.m
//  OC-UI-Groupon
//
//  Created by Gaoxiang Zhang on 2020/11/8.
//

#import "GXGoodsCell.h"

@interface GXGoodsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLbl;

@end

@implementation GXGoodsCell

+ (instancetype)goodsCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"goods_cell";
    GXGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GXGoodsCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setGoods:(GXGoods *)goods {
    _goods = goods;
    self.imgViewIcon.image = [UIImage imageNamed:goods.icon];
    self.titleLbl.text = goods.title;
    self.priceLbl.text = [NSString stringWithFormat:@"$ %@", goods.price];
    self.buyCountLbl.text = [NSString stringWithFormat:@"%@ 人已购买", goods.buyCount];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
