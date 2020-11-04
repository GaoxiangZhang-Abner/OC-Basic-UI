//
//  GXQuestion.m
//  OC-UI-GuessPicture
//
//  Created by Gaoxiang Zhang on 2020/10/30.
//

#import "GXQuestion.h"

@implementation GXQuestion

- (instancetype)initWithDic: (NSDictionary *)dic {
    if (self = [super init]) {
        self.answer = dic[@"answer"];
        self.icon = dic[@"icon"];
        self.title = dic[@"title"];
        self.options = dic[@"options"];
    }
    return self;
}

+ (instancetype)questionWithDic: (NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

@end
