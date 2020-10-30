//
//  GXApp.h
//  OC-UI-AppManager
//
//  Created by Gaoxiang Zhang on 2020/10/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXApp : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *icon;

- (instancetype)initWithDict: (NSDictionary *)dic;
+ (instancetype)initWithDict: (NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
