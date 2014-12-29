//
//  UITextField+Factory.m
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "UITextField+Factory.h"

@implementation TTXPasswordTextField

- (void)drawTextInRect:(CGRect)rect
{
    if (self.isSecureTextEntry)
    {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.alignment = self.textAlignment;
        
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setValue:[UIFont systemFontOfSize:30] forKey:NSFontAttributeName];
        [attributes setValue:self.textColor forKey:NSForegroundColorAttributeName];
        [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
        
        CGSize textSize = [self.text sizeWithAttributes:attributes];
        
        rect = CGRectInset(rect, 0, (CGRectGetHeight(rect) - textSize.height) * 0.5);
        rect.origin.y = floorf(rect.origin.y);
        
        NSMutableString *redactedText = [NSMutableString new];
        while (redactedText.length < self.text.length)
        {
            [redactedText appendString:@"\u2022"];
        }
        
        [redactedText drawInRect:rect withAttributes:attributes];
    }
    else
    {
        [self drawTextInRect:rect];
    }
}

@end

@implementation UITextField (Factory)

+ (instancetype)normalTextField
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return textField;
}

+ (instancetype)userNameTextFieldWithDelegate:(id<UITextFieldDelegate>)object
{
    UITextField *textField = [self normalTextField];
    textField.returnKeyType = UIReturnKeyNext;
    textField.font = [UIFont systemFontOfSize:16];
    textField.textColor = [UIColor colorWithHexString:@"#606266"];
    textField.delegate = object;
    return textField;
}

+ (instancetype)passwordTextFieldWithDelegate:(id<UITextFieldDelegate>)object
{
    UITextField *textField = [[TTXPasswordTextField alloc] initWithFrame:CGRectZero];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.secureTextEntry = YES;
    textField.delegate = object;
    textField.returnKeyType = UIReturnKeyGo;
    textField.font = [UIFont systemFontOfSize:16];
    textField.textColor = [UIColor colorWithHexString:@"#606266"];
    return textField;
}

+ (instancetype)mailTextFieldWithDelegate:(id<UITextFieldDelegate>)object
{
    UITextField *textField = [self normalTextField];
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = object;
    return textField;
}

@end
