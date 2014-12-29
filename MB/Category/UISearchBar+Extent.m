//
//  UISearchBar+Extent.m
//  MB
//
//  Created by Tongtong Xu on 14/12/9.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "UISearchBar+Extent.h"

@implementation UISearchBar (Extent)

- (void)setTextColor:(UIColor*)color
{
    for (UIView *v in self.subviews)
    {
        if(kiOS7) //checks UIDevice#systemVersion
        {
            for(id subview in v.subviews)
            {
                if ([subview isKindOfClass:[UITextField class]])
                {
                    ((UITextField *)subview).textColor = color;
                }
            }
        }
        
        else
        {
            if ([v isKindOfClass:[UITextField class]])
            {
                ((UITextField *)v).textColor = color;
            }
        }
    }
}
@end
