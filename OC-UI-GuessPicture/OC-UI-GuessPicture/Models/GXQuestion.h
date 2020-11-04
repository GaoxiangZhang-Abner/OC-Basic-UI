//
//  GXQuestion.h
//  OC-UI-GuessPicture
//
//  Created by Gaoxiang Zhang on 2020/10/30.
//

#import <Foundation/Foundation.h>

@interface GXQuestion : NSObject
@property (nonatomic, copy) NSString *answer;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *options;
+ (instancetype)questionWithDic: (NSDictionary *)dic;
@end
