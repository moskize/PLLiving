//
//  LDUserSetting.m
//  PLLivingDemo
//
//  Created by TaoZeyu on 16/7/26.
//  Copyright © 2016年 com.pili-engineering. All rights reserved.
//

#import "LDUserSettingViewController.h"
#import "LDSettingNavigationController.h"
#import "LDAppSettingViewController.h"
#import "LDURLImageView.h"
#import "LDAlertUtil.h"
#import "LDUser.h"

@interface LDUserSettingViewController()
@property (nonatomic, strong) UIImageView *userIconImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIButton *settingButton;
@property (nonatomic, strong) UIButton *testPlayButton;
@end

@implementation LDUserSettingViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *panel = ({
        UIVisualEffectView *panel = [[UIVisualEffectView alloc] init];
        [self.view addSubview:panel];
        panel.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        [panel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.and.left.equalTo(self.view);
            make.right.equalTo(self.view).with.offset(-95);
        }];
        panel;
    });
    
    ({
        UIControl *touchCloseControl = [[UIControl alloc] init];
        [self.view addSubview:touchCloseControl];
        [touchCloseControl addTarget:self action:@selector(_onPressedCloseButton:)
                    forControlEvents:UIControlEventTouchUpInside];
        [touchCloseControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.and.bottom.equalTo(self.view);
            make.left.equalTo(panel.mas_right);
        }];
    });
    
    UIView *userIconContainer = ({
        UIView *container = [[UIView alloc] init];
        [panel addSubview:container];
        container.layer.masksToBounds = YES;
        container.layer.cornerRadius = 40;
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(panel).with.offset(78);
            make.centerX.equalTo(panel);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
        container;
    });
    
    self.userIconImageView = ({
        NSURL *iconURL = [NSURL URLWithString:[LDUser sharedUser].iconURL];
        LDURLImageView *imageView = [[LDURLImageView alloc] initWithURL:iconURL withDefaultImageName:@"user"];
        [userIconContainer addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.and.right.equalTo(userIconContainer);
        }];
        imageView;
    });
    
    self.userNameLabel = ({
        UILabel *label = [[UILabel alloc] init];
        [panel addSubview:label];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:16];
        label.text = [LDUser sharedUser].userName;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userIconImageView.mas_bottom).with.offset(26);
            make.centerX.equalTo(self.userIconImageView);
        }];
        label;
    });
    
    UIView *topLine = ({
        UIView *line = [[UIView alloc] init];
        [panel addSubview:line];
        line.backgroundColor = kcolGraySplitLine;
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(panel).with.offset(452);
            make.left.equalTo(panel).with.offset(17);
            make.right.equalTo(panel).with.offset(-13);
            make.height.mas_equalTo(1);
        }];
        line;
    });
    
    self.settingButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [panel addSubview:button];
        [button setTitle:LDString("setting") forState:UIControlStateNormal];
        [button setTintColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(_onPressedSettingButton:)
         forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topLine.mas_bottom);
            make.height.mas_equalTo(56);
            make.left.and.right.equalTo(panel);
        }];
        button;
    });
    
    UIView *mediumLine = ({
        UIView *line = [[UIView alloc] init];
        [panel addSubview:line];
        line.backgroundColor = kcolGraySplitLine;
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.settingButton.mas_bottom);
            make.left.equalTo(panel).with.offset(17);
            make.right.equalTo(panel).with.offset(-13);
            make.height.mas_equalTo(1);
        }];
        line;
    });
    
    self.testPlayButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [panel addSubview:button];
        [button setTitle:LDString("test-play") forState:UIControlStateNormal];
        [button setTintColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(_onPressedTestPlayButton:)
         forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mediumLine.mas_bottom);
            make.height.mas_equalTo(56);
            make.left.and.right.equalTo(panel);
        }];
        button;
    });
    ({
        UIView *line = [[UIView alloc] init];
        [panel addSubview:line];
        line.backgroundColor = kcolGraySplitLine;
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.testPlayButton.mas_bottom);
            make.left.equalTo(panel).with.offset(17);
            make.right.equalTo(panel).with.offset(-13);
            make.height.mas_equalTo(1);
        }];
    });
}

- (void)_onPressedSettingButton:(id)sender
{
    LDSettingNavigationController *navigationController = [[LDSettingNavigationController alloc] init];
    [navigationController pushViewController:[[LDAppSettingViewController alloc] init] animated:NO];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)_onPressedTestPlayButton:(id)sender
{
    [LDAlertUtil alertParentViewController:self title:LDString("please-input-test-play-url")
                               description:@"" complete:^(NSString *text) {
        if (text) {
            [self.delegate setTestPlayURL:text];
        }
    }];
}

- (void)_onPressedCloseButton:(id)sender
{
    [self.basicViewController removeViewController:self animated:NO completion:nil];
    [self playDisappearAnimationWithComplete:nil];
}

@end
