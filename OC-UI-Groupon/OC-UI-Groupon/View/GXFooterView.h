//
//  GXFooterView.h
//  OC-UI-Groupon
//
//  Created by Gaoxiang Zhang on 2020/11/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GXFooterView;

@protocol GXFooterViewDelegate <NSObject>
@required
- (void)footerViewUpdateDate: (GXFooterView *)footerView;
@end

@interface GXFooterView : UIView

@property (nonatomic, weak) id<GXFooterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
