//
//  TCBankScanViewcontroller.m
//  bankVerify
//
//  Created by 童川 on 2018/5/14.
//  Copyright © 2018年 童川 QQ:731358928. All rights reserved.
//

#import "TCBankScanViewcontroller.h"
#import "TCBankOverlayView.h"
#import "TCScanManger.h"

@interface TCBankScanViewcontroller ()

@property (nonatomic, strong) TCBankOverlayView *bankOverlayView;

@property (nonatomic, strong) TCScanManger *cameraManager;

@end

@implementation TCBankScanViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    [self.view insertSubview:self.bankOverlayView atIndex:0];
    self.cameraManager.sessionPreset = AVCaptureSessionPreset1280x720;
    BOOL isOpenCamera = [self.cameraManager configBankScanManager];
    if (isOpenCamera) {
        
        UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view insertSubview:view atIndex:0];
        AVCaptureVideoPreviewLayer *preLayer = [AVCaptureVideoPreviewLayer layerWithSession: self.cameraManager.captureSession];
        preLayer.frame = [UIScreen mainScreen].bounds;
        
        preLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        [view.layer addSublayer:preLayer];
        
        [self.cameraManager startSession];
    }
    else {
        NSLog(@"打开相机失败");
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    __typeof(self) weakSelf = self;
    self.cameraManager.bankScanSuccess = ^(id x) {
      
        [weakSelf showResult:x];
    };
    
//    [self.cameraManager.bankScanSuccess subscribeNext:^(id x) {
//        [self showResult:x];
//    }];
//    [self.cameraManager.scanError subscribeNext:^(id x) {
//
//    }];
}

- (void)showResult:(id)result {
    
    TCScanResultModel *model = (TCScanResultModel *)result;
    NSString *message = [NSString stringWithFormat:@"%@\n%@", model.bankName, model.bankNumber];
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"扫描成功" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertV show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (TCBankOverlayView *)bankOverlayView{
    
    if (!_bankOverlayView) {
        CGRect rect = [TCBankOverlayView getBankOverlayFram:[UIScreen mainScreen].bounds];
        _bankOverlayView = [[TCBankOverlayView alloc]initWithFrame:rect];
    }
    return _bankOverlayView;
}
- (TCScanManger *)cameraManager{
    
    if (!_cameraManager) {
        
        _cameraManager = [[TCScanManger alloc] init];
    }
    return _cameraManager;
}

@end
