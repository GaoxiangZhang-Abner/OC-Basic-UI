//
//  GXCars.h
//  OC-UI-UITableViewGroup
//
//  Created by Gaoxiang Zhang on 2020/11/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXCarBrand : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSArray *cars;

- (instancetype)initWithDict: (NSDictionary *)dict;
+ (instancetype)carBrandWithDict: (NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
