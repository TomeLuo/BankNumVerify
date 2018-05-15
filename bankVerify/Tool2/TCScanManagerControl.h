//
//  TCScanManagerControl.h
//  bankVerify
//
//  Created by 童川 on 2018/5/11.
//  Copyright © 2018年 童川 QQ:731358928. All rights reserved.
//

#import "TCSanManagerInitialize.h"

@interface TCScanManagerControl : TCSanManagerInitialize

- (void)startSession;

- (void)stopSession;

- (void)resetConfig;

- (void)resetParams;

- (void)doSomethingWhenWillAppear;

- (void)doSomethingWhenWillDisappear;

//- (void)parseIDCardImageBuffer:(CVImageBufferRef)imageBuffer;

- (void)parseBankImageBuffer:(CVImageBufferRef)imageBuffer;

//选择前置和后置
- (BOOL)switchCameras;
// 闪关灯
- (void)setFlashMode:(AVCaptureFlashMode)flashMode;
// 手电筒
- (void)setTorchMode:(AVCaptureTorchMode)torchMode;
// 焦距
- (void)focusAtPoint:(CGPoint)point;
// 曝光量
- (void)exposeAtPoint:(CGPoint)point;
//重置曝光
- (void)resetFocusAndExposureModes;

@end
