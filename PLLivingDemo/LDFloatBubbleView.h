//
//  LDFloatBubbleView.h
//  PLLivingDemo
//
//  Created by TaoZeyu on 2016/9/21.
//  Copyright © 2016年 com.pili-engineering. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDFloatBubbleItem : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *iconName;
@property (nonatomic, assign, readonly) BOOL defaultOn;
@property (nonatomic, strong, readonly) void (^callback)(BOOL on);

- (instancetype)initWithTitle:(NSString *)title withIconName:(NSString *)iconName
                withDefaultOn:(BOOL)defaultOn withCallback:(void (^)(BOOL on))callback;

@end

@interface LDFloatBubbleView : UIView

- (instancetype)initWithItems:(NSArray<LDFloatBubbleItem *> *)items;

@end
