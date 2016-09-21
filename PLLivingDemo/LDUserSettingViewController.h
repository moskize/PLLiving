//
//  LDUserSetting.h
//  PLLivingDemo
//
//  Created by TaoZeyu on 16/7/26.
//  Copyright © 2016年 com.pili-engineering. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LDBlurViewController.h"

@protocol LDUserSettingViewControllerDelegate <NSObject>

- (void)changeTestPlayURL:(NSString *)testPlayURL;

@end

@interface LDUserSettingViewController : LDBlurViewController

@property (nonatomic, weak) id<LDUserSettingViewControllerDelegate> delegate;

@end
