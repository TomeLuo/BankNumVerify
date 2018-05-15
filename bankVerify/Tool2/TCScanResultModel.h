//
//  TCScanResultModel.h
//  bankVerify
//
//  Created by 童川 on 2018/5/11.
//  Copyright © 2018年 童川 QQ:731358928. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TCScanResultModel : NSObject

@property (nonatomic, copy  ) NSString *bankNumber;
@property (nonatomic, copy  ) NSString *bankName;
@property (nonatomic, strong) UIImage  *bankImage;

@end
