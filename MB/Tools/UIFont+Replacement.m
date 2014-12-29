//
//  UIFont+Replacement.m
//  FontReplacer
//
//  Created by Cédric Luthi on 2011-08-08.
//  Copyright (c) 2011 Cédric Luthi. All rights reserved.
//

#import "UIFont+Replacement.h"
#import <objc/runtime.h>
#import "ConciseKit.h"

@implementation UIFont (Replacement)

static NSDictionary *s_replacementDictionary = nil;

#pragma mark - Swizzle

+ (void)replaceFontMethods {

    [self replaceMethod:@selector(fontWithName:size:) withMethod:@selector(replacement_fontWithName:size:)];
    [self replaceMethod:NSSelectorFromString(@"systemFontOfSize:traits:") withMethod:@selector(replacement_systemFontOfSize:traits:)];
    if (([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending))
        [self replaceMethod:@selector(fontWithDescriptor:size:) withMethod:@selector(replacement_fontWithDescriptor:size:)];
    else
        [self replaceMethod:NSSelectorFromString(@"fontWithName:size:traits:") withMethod:@selector(replacement_fontWithName:size:traits:)];
}

+ (void)replaceMethod:(SEL)origin withMethod:(SEL)replacement {
    [ConciseKit swizzleClassMethod:origin with:replacement in:[UIFont class]];
}

#pragma mark - Replacement Methods

// 特定字体
+ (UIFont *)replacement_fontWithName:(NSString *)fontName size:(CGFloat)fontSize {
//    fontName = [self replaceSystemFontName:fontName];
	NSString *replacementFontName = [s_replacementDictionary objectForKey:fontName];
	return [self replacement_fontWithName:replacementFontName ?: fontName size:fontSize];
}

+ (UIFont *)replacement_fontWithName:(NSString *)fontName size:(CGFloat)fontSize traits:(int)traits {
	NSString *replacementFontName = [s_replacementDictionary objectForKey:fontName];
	return [self replacement_fontWithName:replacementFontName ?: fontName size:fontSize traits:traits];
}

// Nib或StoryBoard中创建Custom字体，会直接调用此方法
+ (UIFont *)replacement_fontWithDescriptor:(UIFontDescriptor *)fontDescriptor size:(CGFloat)fontSize {
    if (fontSize == 0) fontSize = 17;
    NSString *replacementFontName = [s_replacementDictionary objectForKey:fontDescriptor.postscriptName];
    UIFontDescriptor *replacementFontDescriptor = (replacementFontName
                                                   ? [fontDescriptor fontDescriptorByAddingAttributes:@{UIFontDescriptorNameAttribute: replacementFontName}]
                                                   : fontDescriptor);
    return [self replacement_fontWithDescriptor:replacementFontDescriptor size:fontSize];
}

// 代码创建系统字体systemFontOfSize:，会调用此方法
// Nib或StoryBoard中创建系统字体，会直接调用此方法
+ (UIFont *)replacement_systemFontOfSize:(CGFloat)fontSize traits:(int)traits {
    // 对于系统字体，替换为与helvatic等价的字体
    NSString *fontName = @"Helvetica";
    if (traits == 0)
        fontName = @"Helvetica";
    else if (traits == 1)
        fontName = @"Helvetica-Oblique";
    else if (traits == 2)
        fontName = @"Helvetica-Bold";

	NSString *replacementFontName = [s_replacementDictionary objectForKey:fontName];
    if (replacementFontName)
        return [self replacement_fontWithName:replacementFontName size:fontSize];
    else
        return [self replacement_systemFontOfSize:fontSize traits:traits];
}

#pragma mark - Replacement Dictionary

+ (NSDictionary *)replacementDictionary {
	return s_replacementDictionary;
}

+ (void)setReplacementDictionary:(NSDictionary *)aReplacementDictionary {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self replaceFontMethods];
    });
    
	if (aReplacementDictionary == s_replacementDictionary)
		return;
	
	for (id key in [aReplacementDictionary allKeys])
	{
		if (![key isKindOfClass:[NSString class]])
		{
			NSLog(@"ERROR: Replacement font key must be a string.");
			return;
		}
		
		id value = [aReplacementDictionary valueForKey:key];
		if (![value isKindOfClass:[NSString class]])
		{
			NSLog(@"ERROR: Replacement font value must be a string.");
			return;
		}
	}
	
	s_replacementDictionary = aReplacementDictionary;
	
	for (id key in [s_replacementDictionary allKeys])
	{
		NSString *fontName = [s_replacementDictionary objectForKey:key];
		UIFont *font = [UIFont fontWithName:fontName size:10];
		if (!font)
			NSLog(@"WARNING: replacement font '%@' is not available.", fontName);
	}
}

@end
