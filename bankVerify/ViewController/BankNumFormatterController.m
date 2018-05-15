//
//  BankNumFormatterController.m
//  bankVerify
//
//  Created by 童川 on 2018/5/9.
//  Copyright © 2018年 童川 QQ:731358928. All rights reserved.
//

#import "BankNumFormatterController.h"
#import "TCCardNumberFormatter.h"

@interface BankNumFormatterController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bankNumTF;

@property (strong ,nonatomic) TCCardNumberFormatter *cardNumFormatter;

@end

@implementation BankNumFormatterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bankNumTF.delegate = self;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.bankNumTF) {
        [self.cardNumFormatter bankNumField:textField shouldChangeCharactersInRange:range replacementString:string];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (TCCardNumberFormatter *)cardNumFormatter{
    
    if (!_cardNumFormatter) {
        _cardNumFormatter = [[TCCardNumberFormatter alloc] init];
    }
    return _cardNumFormatter;
}

@end
