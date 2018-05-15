//
//  TCScanBaseManager.m
//  bankVerify
//
//  Created by 童川 on 2018/5/10.
//  Copyright © 2018年 童川 QQ:731358928. All rights reserved.
//

#import "TCScanBaseManager.h"

@implementation TCScanBaseManager

- (AVCaptureSession *)captureSession {
    if (!_captureSession) {
        _captureSession = [[AVCaptureSession alloc] init];
        [self.captureSession beginConfiguration];
    }
    return _captureSession;
}

- (NSString *)sessionPreset {
    if (!_sessionPreset) {
        _sessionPreset = AVCaptureSessionPreset1280x720;
    }
    return _sessionPreset;
}

- (AVCaptureVideoDataOutput *)videoDataOutput {
    if (!_videoDataOutput) {
        _videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
        _videoDataOutput.alwaysDiscardsLateVideoFrames = YES;
        _videoDataOutput.videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange],(id)kCVPixelBufferPixelFormatTypeKey, nil];
    }
    return _videoDataOutput;
}
// 相机能否切换前置后置
- (BOOL)canSwitchCameras {
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count] > 1;
}

// 活跃的相机设备
- (AVCaptureDevice *)activeCamera {
    return self.activeVideoInput.device;
}
// 不活跃的相机设备
- (AVCaptureDevice *)inactiveCamera {
    AVCaptureDevice *device = nil;
    if ([self canSwitchCameras]) {
        if ([self activeCamera].position == AVCaptureDevicePositionBack) {
            device = [self cameraWithPosition:AVCaptureDevicePositionFront];
        }
        else {
            device = [self cameraWithPosition:AVCaptureDevicePositionBack];
        }
    }
    return device;
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

#pragma mark - Flash 闪光灯
- (AVCaptureFlashMode)flashMode {
    return [[self activeCamera] flashMode];
}

#pragma mark - Torch 手电筒
- (BOOL)cameraHasTorch {
    return [[self activeCamera] hasTorch];
}

- (AVCaptureTorchMode)torchMode {
    return [[self activeCamera] torchMode];
}

#pragma mark - Focus 焦距
- (BOOL)cameraSupportsTapToFocus {
    return [[self activeCamera] isFocusPointOfInterestSupported];
}

/*
- (RACSubject *)receiveSubject {
    if (!_receiveSubject) {
        _receiveSubject = [RACSubject subject];
    }
    return _receiveSubject;
}

- (RACSubject *)bankScanSuccess {
    if (!_bankScanSuccess) {
        _bankScanSuccess = [RACSubject subject];
    }
    return _bankScanSuccess;
}

- (RACSubject *)idCardScanSuccess {
    if (!_idCardScanSuccess) {
        _idCardScanSuccess = [RACSubject subject];
    }
    return _idCardScanSuccess;
}
*/
@end
