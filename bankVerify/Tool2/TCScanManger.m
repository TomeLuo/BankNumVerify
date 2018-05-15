//
//  TCScanManger.m
//  bankVerify
//
//  Created by 童川 on 2018/5/14.
//  Copyright © 2018年 童川 QQ:731358928. All rights reserved.
//

#import "TCScanManger.h"

@implementation TCScanManger

- (BOOL)configBankScanManager {

    return [self configSession];
}
- (BOOL)configSession {
    
    [self resetConfig];
    dispatch_queue_t captureQueue = dispatch_queue_create("www.captureQue.com", NULL);
    self.captureSession.sessionPreset = AVCaptureSessionPreset1280x720;
    
    if (![self configInPutAtQue:captureQueue] || ![self configOutPutAtQue:captureQueue]) {
        return NO;
    }
    [self configConnection];
    
    AVCaptureDevice *device = [self activeCamera];
    
    if(YES == [device lockForConfiguration:NULL]) {
        
        if([device respondsToSelector:@selector(setSmoothAutoFocusEnabled:)] && [device isSmoothAutoFocusSupported]) {
            [device setSmoothAutoFocusEnabled:YES];
        }
        AVCaptureFocusMode currentMode = [device focusMode];
        if(currentMode == AVCaptureFocusModeLocked) {
            
            currentMode = AVCaptureFocusModeAutoFocus;
        }
        if([device isFocusModeSupported:currentMode]) {
            
            [device setFocusMode:currentMode];
        }
        [device unlockForConfiguration];
    }
    [self.captureSession commitConfiguration];
    
    __typeof(self) weakSelf = self;
    self.receiveSubject = ^(id x) {
       
        CVImageBufferRef imageBuffer = (__bridge CVImageBufferRef)(x);
        
        [weakSelf doRec:imageBuffer];
    };
    
    self.bankScanSuccess = ^(id x) {
        
    };
    self.scanError = ^(id x) {
        
    };
//    [self.receiveSubject subscribeNext:^(id x) {
//        CVImageBufferRef imageBuffer = (__bridge CVImageBufferRef)(x);
//        [self doRec:imageBuffer];
//    }];
//    [self.bankScanSuccess subscribeNext:^(id x) {
//
//    }];
//    [self.idCardScanSuccess subscribeNext:^(id x) {
//
//    }];
//    [self.scanError subscribeNext:^(id x) {
//
//    }];
    return YES;
}

- (void)doRec:(CVImageBufferRef)imageBuffer {
    
    @synchronized(self) {
        
        self.isInProcessing = YES;
        if (self.isHasResult)  return;
        CVBufferRetain(imageBuffer);
        
        if(CVPixelBufferLockBaseAddress(imageBuffer, 0) == kCVReturnSuccess) {
            
           [self parseBankImageBuffer:imageBuffer];
            
        }
        CVBufferRelease(imageBuffer);
    }
}

@end
