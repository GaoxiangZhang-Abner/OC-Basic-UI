//
//  GXApp.m
//  OC-UI-AppManager
//
//  Created by Gaoxiang Zhang on 2020/10/29.
//

#import "GXApp.h"

@implementation GXApp

- (instancetype)initWithDict: (NSDictionary *)dic {
    if (self = [super init]) {
        self.name = dic[@"name"];
        self.icon = dic[@"icon"];
    }
    
    return self;
}

+ (instancetype)initWithDict: (NSDictionary *)dic {
    return [[self alloc] initWithDict:dic];
}

@end
