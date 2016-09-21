//
//  LDAlertUtil.m
//  PLLivingDemo
//
//  Created by TaoZeyu on 16/7/20.
//  Copyright © 2016年 com.pili-engineering. All rights reserved.
//

#import "LDAlertUtil.h"

@implementation LDAlertUtil

+ (void)alertParentViewController:(UIViewController *)parentViewController
                            title:(NSString *)title error:(NSString *)errorMsg
                         complete:(void (^)())complete
{
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title
                                                                message:errorMsg
                                                         preferredStyle:UIAlertControllerStyleAlert];
    [av addAction:[UIAlertAction actionWithTitle:LDString("I-see")
                                           style:UIAlertActionStyleDestructive
                                         handler:^(UIAlertAction * _Nonnull action) {
                                             complete();
                                         }]];
    [parentViewController presentViewController:av animated:true completion:nil];
}

+ (void)alertParentViewController:(UIViewController *)parentViewController
                            title:(NSString *)title description:(NSString *)description
                         complete:(void (^)(NSString *text))complete
{
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title
                                                                message:description
                                                         preferredStyle:UIAlertControllerStyleAlert];
    __block UITextField *inputTextFiled = nil;
    [av addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        inputTextFiled = textField;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [av addAction:[UIAlertAction actionWithTitle:LDString("OK")
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * _Nonnull action) {
                                             if (!inputTextFiled.text || inputTextFiled.text.length == 0) {
                                                 complete(nil);
                                             } else {
                                                 complete(inputTextFiled.text);
                                             }
                                         }]];
    [av addAction:[UIAlertAction actionWithTitle:LDString("Cancel")
                                           style:UIAlertActionStyleCancel
                                         handler:^(UIAlertAction * _Nonnull action) {
                                             complete(nil);
                                         }]];
    [parentViewController presentViewController:av animated:true completion:nil];
}

@end
