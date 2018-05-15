//
//  TCSanManagerInitialize.h
//  bankVerify
//
//  Created by 童川 on 2018/5/11.
//  Copyright © 2018年 童川 QQ:731358928. All rights reserved.
//

#import "TCScanBaseManager.h"

@interface TCSanManagerInitialize : TCScanBaseManager

- (void)configIDScan;

- (BOOL)configOutPutAtQue:(dispatch_queue_t)queue;

- (BOOL)configInPutAtQue:(dispatch_queue_t)queue;

- (void)configConnection;

@end
