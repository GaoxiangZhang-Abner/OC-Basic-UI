//
//  GXGood.m
//  OC-UI-Groupon
//
//  Created by Gaoxiang Zhang on 2020/11/8.
//

#import "GXGoods.h"

@implementation GXGoods

- (instancetype)initWithDict: (NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)goodsWithDict: (NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
