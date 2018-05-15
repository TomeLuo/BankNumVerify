//
//  UITextField+TCRange.h
//  bankVerify
//
//  Created by 童川 on 2018/5/9.
//  Copyright © 2018年 童川 QQ:731358928. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (TCRange)

- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;

@end
