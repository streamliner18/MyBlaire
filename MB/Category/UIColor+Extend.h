//
//  UIColor+Extend.h


#import <UIKit/UIKit.h>

@interface UIColor (Extend)

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert alpha:(float)alpha;

+ (UIColor *)lightRandom;

@end
