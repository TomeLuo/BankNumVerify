//
//  TCScanBaseManager.h
//  bankVerify
//
//  Created by 童川 on 2018/5/10.
//  Copyright © 2018年 童川 QQ:731358928. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "exbankcard.h"
#import "excards.h"
#import "RectManager.h"
#import "BankCardSearch.h"
#import "TCScanResultModel.h"
#import "UIImage+Extend.h"
#import "UIColor+expanded.h"

typedef void(^receiveSubject)(id x);
typedef void(^bankScanSuccess)(id x);
typedef void(^scanError)(id x);

@interface TCScanBaseManager : NSObject<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate,AVCaptureMetadataOutputObjectsDelegate>

/*需要用到ReactiveCocoa 2.3.1版本*/
//@property (nonatomic, strong) RACSubject *receiveSubject;
//@property (nonatomic, strong) RACSubject *bankScanSuccess;
//@property (nonatomic, strong) RACSubject *scanError;
/*为了不植入第三方改用block回调处理*/
@property (nonatomic,  copy) receiveSubject receiveSubject;

@property (nonatomic,  copy) bankScanSuccess bankScanSuccess;

@property (nonatomic,  copy) scanError scanError;

@property (nonatomic, assign) BOOL verify;

@property (nonatomic, strong) AVCaptureSession *captureSession;//捕获链接

@property (nonatomic, copy  ) NSString *sessionPreset;//图片质量

@property (nonatomic, assign) BOOL isInProcessing;

@property (nonatomic, assign) BOOL isHasResult;

//出流
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;

//输入流
@property (nonatomic, strong) AVCaptureDeviceInput *activeVideoInput;

//能否切换前置后置
- (BOOL)canSwitchCameras;

- (AVCaptureDevice *)activeCamera;

- (AVCaptureDevice *)inactiveCamera;

//闪光灯
- (AVCaptureFlashMode)flashMode;

//有无手电筒
- (BOOL)cameraHasTorch;
//
- (AVCaptureTorchMode)torchMode;

//能否调整焦距
- (BOOL)cameraSupportsTapToFocus;
@end
