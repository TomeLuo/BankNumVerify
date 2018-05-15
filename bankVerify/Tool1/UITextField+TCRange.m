//
//  UITextField+TCRange.m
//  bankVerify
//
//  Created by 童川 on 2018/5/9.
//  Copyright © 2018年 童川 QQ:731358928. All rights reserved.
//

#import "UITextField+TCRange.h"

@implementation UITextField (TCRange)

- (NSRange)selectedRange {
    
    UITextPosition *beginning = self.beginningOfDocument;
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}
- (void)setSelectedRange:(NSRange)range {
    
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}


@end
