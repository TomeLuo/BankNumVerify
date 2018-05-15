
//
//  TCSanManagerInitialize.m
//  bankVerify
//
//  Created by 童川 on 2018/5/11.
//  Copyright © 2018年 童川 QQ:731358928. All rights reserved.
//

#import "TCSanManagerInitialize.h"

@implementation TCSanManagerInitialize

static bool  initFlag = NO;

- (void)configIDScan {
    
    if (!initFlag) {
        const char *thePath = [[[NSBundle mainBundle] resourcePath]UTF8String];
        int ret = EXCARDS_Init(thePath);
        ret != 0 ? NSLog(@"初始化失败：ret=%d",ret):nil;
        initFlag = YES;
    }
}
- (BOOL)configOutPutAtQue:(dispatch_queue_t)queue {
    
    [self.videoDataOutput setSampleBufferDelegate:self queue:queue];
    BOOL isCanAddInput = [self.captureSession canAddOutput:self.videoDataOutput];
    if (!isCanAddInput) return NO;
    [self.captureSession addOutput:self.videoDataOutput];
    return YES;
}

- (BOOL)configInPutAtQue:(dispatch_queue_t)queue {
    
    NSError *error;
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if (!videoInput) return NO;
    if ([self.captureSession canAddInput:videoInput]) {
        [self.captureSession addInput:videoInput];
        self.activeVideoInput = videoInput;
    }
    if (error && error.description) {
        NSLog(@"%@", error.description);
        return NO;
    }
    return YES;
}

- (void)configConnection {
    
    AVCaptureConnection *videoConnection;
    for (AVCaptureConnection *connection in [self.videoDataOutput connections]) {
        for (AVCaptureInputPort *port in[connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
            }
        }
    }
    if ([videoConnection isVideoStabilizationSupported]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
            videoConnection.enablesVideoStabilizationWhenAvailable = YES;
        }
        else {
            videoConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
        }
    }
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    CVPixelBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    if ([captureOutput isEqual:self.videoDataOutput]) {
        if(self.isInProcessing == NO) {
//            [self.receiveSubject sendNext:(__bridge id)(imageBuffer)];
            self.receiveSubject((__bridge id)(imageBuffer));
        }
    }
}
@end
