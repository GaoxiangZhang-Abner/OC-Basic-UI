//
//  GXGood.h
//  OC-UI-Groupon
//
//  Created by Gaoxiang Zhang on 2020/11/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXGoods : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *buyCount;

- (instancetype)initWithDict: (NSDictionary *)dict;
+ (instancetype)goodsWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
