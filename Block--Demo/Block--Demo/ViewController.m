//
//  ViewController.m
//  Block--Demo
//
//  Created by 薛 on 2020/3/31.
//  Copyright © 2020 Xue. All rights reserved.


//  Block 特性：1：具有自动捕获外部的能力。2：匿名函数。本质是：变量
//  Block分类：1：全局静态block， 2：堆block， 3：栈block。
//* GlobalBlock: 没有引用局部变量 or 全局变量 or 静态变量
//* MallocBlock: 引用局部变量，并且赋值给强引用， copy 或者 strong
//* StackBlock: 引用局部变量，不赋值给强引用  

#import "ViewController.h"
#import "SecondViewController.h"
typedef void (^KCBlock)(id data); //定义block

@interface ViewController ()
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BlockDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    [self.view addSubview:self.button3];
    [self.view addSubview:self.button4];
}

-(UIButton *)button1{
    if (!_button1 ) {
          _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
          [_button1 setTitle:@"全局静态block" forState:UIControlStateNormal];
          [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          _button1.titleLabel.font = [UIFont systemFontOfSize:15 weight:0.5];
          _button1.frame = CGRectMake(60, 90, [UIScreen mainScreen].bounds.size.width - 120, 40);
          _button1.backgroundColor = [UIColor orangeColor];
        [_button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}

-(UIButton *)button2{
    if (!_button2 ) {
          _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
          [_button2 setTitle:@"堆block" forState:UIControlStateNormal];
          [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          _button2.titleLabel.font = [UIFont systemFontOfSize:15 weight:0.5];
          _button2.frame = CGRectMake(60, 150, [UIScreen mainScreen].bounds.size.width - 120, 40);
          _button2.backgroundColor = [UIColor orangeColor];
        [_button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}

-(UIButton *)button3{
    if (!_button3) {
          _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
          [_button3 setTitle:@"堆block" forState:UIControlStateNormal];
          [_button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          _button3.titleLabel.font = [UIFont systemFontOfSize:15 weight:0.5];
          _button3.frame = CGRectMake(60, 210, [UIScreen mainScreen].bounds.size.width - 120, 40);
          _button3.backgroundColor = [UIColor orangeColor];
        [_button3 addTarget:self action:@selector(button3Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button3;
}

-(UIButton *)button4{
    if (!_button4) {
          _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
          [_button4 setTitle:@"block循环__weak解决方式" forState:UIControlStateNormal];
          [_button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          _button4.titleLabel.font = [UIFont systemFontOfSize:15 weight:0.5];
          _button4.frame = CGRectMake(60, 270, [UIScreen mainScreen].bounds.size.width - 120, 40);
          _button4.backgroundColor = [UIColor orangeColor];
        [_button4 addTarget:self action:@selector(button4Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button4;
}


- (void)button1Action:(id)sender{
    //声明block 并调用block
    void (^myBlock)(void) = ^{
        NSLog(@"这是我的全局block");
    };
    //调用block  这是一个全局静态block
    myBlock();
    NSLog(@"%@",myBlock);
}

- (void)button2Action:(id)sender{
    //声明block 并调用block
    int a = 10;
    void (^myBlock)(void) = ^{
        NSLog(@"这是我的堆 block, %d",a);
    };
    //调用block
    myBlock();
    NSLog(@"%@",myBlock);
}
- (void)button3Action:(id)sender{
    //声明block 并调用block
    int a = 15;
    void (^myBlock)(void) = ^{
        NSLog(@"这是我的堆 block, %d",a);
    };
    //调用block
    myBlock();
    NSLog(@"%@",^{
         NSLog(@"这是我的堆 block, %d",a);
    });
}

//Block 循环引用问题
- (void)button4Action:(id)sender{
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (void)dealloc{
    NSLog(@"dealloc 来了！！");
}
@end
