//
//  GXCars.m
//  OC-UI-UITableViewGroup
//
//  Created by Gaoxiang Zhang on 2020/11/7.
//

#import "GXCarBrand.h"

@implementation GXCarBrand

- (instancetype)initWithDict: (NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}


+ (instancetype)carBrandWithDict: (NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
