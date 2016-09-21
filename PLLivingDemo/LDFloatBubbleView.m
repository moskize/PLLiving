//
//  LDFloatBubbleView.m
//  PLLivingDemo
//
//  Created by TaoZeyu on 2016/9/21.
//  Copyright © 2016年 com.pili-engineering. All rights reserved.
//

#import "LDFloatBubbleView.h"

@implementation LDFloatBubbleItem

- (instancetype)initWithTitle:(NSString *)title withIconName:(NSString *)iconName
                withDefaultOn:(BOOL)defaultOn withCallback:(void (^)(BOOL))callback
{
    if (self = [self init]) {
        _title = title;
        _iconName = iconName;
        _defaultOn = defaultOn;
        _callback = callback;
    }
    return self;
}

@end

@interface LDFloatBubbleView ()
@property (nonatomic, strong) NSArray<LDFloatBubbleItem *> *items;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *onArray;
@end

@implementation LDFloatBubbleView

- (instancetype)initWithItems:(NSArray<LDFloatBubbleItem *> *)items
{
    if (self = [self init]) {
        self.items = items;
        
        NSMutableArray<NSNumber *> *onArray = [[NSMutableArray <NSNumber *> alloc] init];
        self.onArray = onArray;
        
        UIView *bubleView = ({
            UIView *bubleView = [[UIView alloc] init];
            bubleView.backgroundColor = [UIColor whiteColor];
            bubleView.layer.cornerRadius = 5;
            [self addSubview:bubleView];
            bubleView;
        });
        
        NSMutableArray<UIButton *> *buttons = [[NSMutableArray<UIButton *> alloc] init];
        
        MASViewAttribute *previousViewAttribue = bubleView.mas_top;
        
        for (NSUInteger i = 0; i < items.count; ++i) {
            LDFloatBubbleItem *item = items[i];
            [onArray addObject:@(item.defaultOn)];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [bubleView addSubview:button];
            [buttons addObject:button];
            [button setTag:i];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(previousViewAttribue).with.offset(5);
                make.left.and.right.equalTo(self);
                make.height.mas_equalTo(60);
            }];
            previousViewAttribue = button.mas_bottom;
            
            [button addTarget:self action:@selector(onPressedButton:)
             forControlEvents:UIControlEventTouchUpInside];
            
            [self refreshViewWithButton:button withItem:item withOn:item.defaultOn];
        }
        [bubleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.and.right.equalTo(self.mas_top);
            make.bottom.equalTo(previousViewAttribue).with.offset(5);
        }];
        
        UIView *arrowView = [[UIView alloc] init];
        [self addSubview:arrowView];
        
        [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bubleView.mas_bottom);
            make.centerY.equalTo(bubleView);
        }];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(arrowView.mas_bottom);
            make.width.mas_equalTo(140);
        }];
    }
    return self;
}

- (void)refreshViewWithButton:(UIButton *)button withItem:(LDFloatBubbleItem *)item withOn:(BOOL)on
{
    NSString *title = [NSString stringWithFormat:(on? LDString("turn-off-XXX"): LDString("turn-on-XXX")), item.title];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:item.iconName] forState:UIControlStateNormal];
    [button setTintColor:on? kcolButtonOnState: kcolButtonOffState];
}

- (void)onPressedButton:(UIButton *)button
{
    NSUInteger index = button.tag;
    LDFloatBubbleItem *item = self.items[index];
    BOOL on = [self.onArray[index] boolValue];
    on = !on;
    [self refreshViewWithButton:button withItem:item withOn:on];
    self.onArray[index] = @(on);
    item.callback(on);
}


@end
