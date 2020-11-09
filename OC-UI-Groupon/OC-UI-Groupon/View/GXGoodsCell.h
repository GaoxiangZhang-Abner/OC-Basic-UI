//
//  GXGoodsCell.h
//  OC-UI-Groupon
//
//  Created by Gaoxiang Zhang on 2020/11/8.
//

#import <UIKit/UIKit.h>
#import "GXGoods.h"

NS_ASSUME_NONNULL_BEGIN

@interface GXGoodsCell : UITableViewCell

@property (nonatomic, strong) GXGoods *goods;

+ (instancetype)goodsCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
