//
//  ThirdViewController.m
//  Block--Demo
//
//  Created by 薛 on 2020/4/6.
//  Copyright © 2020 Xue. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UITextField  *textF;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button1];
    [self.view addSubview:self.textF];
}
- (UITextField *)textF{
    if (!_textF) {
        _textF = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, [UIScreen mainScreen].bounds.size.width - 40, 30)];
        _textF.backgroundColor = [UIColor lightGrayColor];
        _textF.font = [UIFont systemFontOfSize:13 weight:0.5];
        _textF.borderStyle = UITextBorderStyleRoundedRect;
        _textF.enabled = YES;
    }
    return _textF;
}

-(UIButton *)button1{
    if (!_button1 ) {
          _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
          [_button1 setTitle:@"返回上页面" forState:UIControlStateNormal];
          [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          _button1.titleLabel.font = [UIFont systemFontOfSize:15 weight:0.5];
          _button1.frame = CGRectMake(60, 90, [UIScreen mainScreen].bounds.size.width - 120, 40);
          _button1.backgroundColor = [UIColor orangeColor];
        [_button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}
- (void)button1Action:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    self.myBlock(self.textF.text);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
