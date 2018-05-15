//
//  TCCardNumberFormatter.h
//  bankVerify
//
//  Created by 童川 on 2018/5/9.
//  Copyright © 2018年 童川 QQ:731358928. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TCCardNumberFormatter : NSObject

/**
 *  默认为4，即4个数一组 用空格分隔
 */
@property (assign, nonatomic) NSInteger groupSize;

/**
 *  分隔符 默认为空格
 */
@property (copy,   nonatomic) NSString *separator;


- (void)bankNumField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
