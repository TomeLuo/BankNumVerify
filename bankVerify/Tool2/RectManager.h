//
//  TCScanBaseManager.h
//  bankVerify
//
//  Created by 童川 on 2018/5/10.
//  Copyright © 2018年 童川 QQ:731358928. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RectManager : UIView


@property (nonatomic, assign)CGRect subRect;

+ (CGRect)getEffectImageRect:(CGSize)size;
+ (CGRect)getGuideFrame:(CGRect)rect;

+ (int)docode:(unsigned char *)pbBuf len:(int)tLen;
+ (CGRect)getCorpCardRect:(int)width  height:(int)height guideRect:(CGRect)guideRect charCount:(int) charCount;

+ (char *)getNumbers;

@end
