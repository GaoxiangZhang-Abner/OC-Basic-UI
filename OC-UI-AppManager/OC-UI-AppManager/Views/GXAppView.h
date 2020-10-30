//
//  GXAppView.h
//  OC-UI-AppManager
//
//  Created by Gaoxiang Zhang on 2020/10/29.
//

#import <UIKit/UIKit.h>

@class GXApp;
@interface GXAppView : UIView

@property (nonatomic, strong) GXApp* model;

+ (instancetype) appView;

@end

