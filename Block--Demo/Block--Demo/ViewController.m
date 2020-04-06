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

#import <AFNetworking.h>
#import "DownloadManager.h"

typedef void (^KCBlock)(id data); //定义block

@interface ViewController (){
    int aa;
}
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;
@property (nonatomic, strong) UIButton *downloadImageBtn;
@property (nonatomic, strong) UIImageView *myImgView;

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
    [self.view addSubview:self.downloadImageBtn];
    [self.view addSubview:self.myImgView];
    
    aa = 100;
    [self demo10];
     
     // 声明静态局部变量global
    static int global = 100;

     void(^myBlock2)(void) = ^{
         NSLog(@"global = %d", global);
     };
     // 调用后控制台输出"global = 100"
     myBlock2();
    
}

//Block访问变量的问题************************************************

//block 中可以访问局部变量
-(void)demo1{
    int a = 10;
    void (^myBlock)(void) = ^{
        NSLog(@"a的值为：%d", a);
    };
    myBlock();
}
//在声明Block之后、调用Block之前对局部变量进行修改,在调用Block时局部变量值是修改之前的旧值
- (void)demo2{
    int a = 10;
    void (^myBlock)(void) = ^{
        NSLog(@"a的值为：%d", a);
    };
    a = 20;
    // a的值为：10
    myBlock();
}
//在Block中不可以直接修改局部变量
- (void)demo3{
    int a = 10;
    void (^myBlock)(void) = ^{
//        a++; //这一句报错
        NSLog(@"a的值为：%d", a);
    };
    // 调用后控制台输出"a = 10"
    myBlock();
}

// Block内访问__block修饰的局部变量
- (void)demo4{
//在局部变量前使用下划线__block修饰,在声明Block之后、调用Block之前对局部变量进行修改,在调用Block时局部变量值是修改之后的新值
    __block int a = 10;
    void(^myBlock)(void) = ^{
        NSLog(@"a的值==%d",a);
    };
    a = 11;
    // 调用后控制台输出"a的值== 11"
    myBlock();
}

//在局部变量前使用下划线__block修饰,在Block中可以直接修改局部变量
- (void)demo5{
    __block int a = 10;
    void(^myBlock)(void) = ^{
        a++;
        NSLog(@"a的值==%d",a);
    };
    // 调用后控制台输出"a的值==11"
    myBlock();

}
//在Block中可以访问全局变量
- (void)demo6{
    void(^myBlock)(void) = ^{
        NSLog(@"aa的值 == %d", self->aa);
    };
    // 调用后控制台输出"aa的值 = 100"
    myBlock();
}
//在声明Block之后、调用Block之前对全局变量进行修改,在调用Block时全局变量值是修改之后的新值
- (void)demo7{
    void(^myBlock)(void) = ^{
          NSLog(@"aa的值 == %d", self->aa);
      };
     aa = 200;
      // 调用后控制台输出"aa的值 == 100"
      myBlock();
}
//在Block中可以直接修改全局变量
- (void)demo8{
    void(^myBlock)(void) = ^{
        self->aa++;
        NSLog(@"aa的值 == %d", self->aa);
      };
      // 调用后控制台输出"aa的值 ==  101"
      myBlock();
}
//在声明Block之后、调用Block之前对静态变量进行修改,在调用Block时静态变量值是修改之后的新值
- (void)demo9{
    static int a = 10;
    void (^myBlock)(void) = ^{
        NSLog(@"a的值==%d",a);
    };
    a = 20;
    myBlock();
}

//在Block中可以直接修改静态变量
- (void)demo10{
    static int a = 10;
     void (^myBlock)(void) = ^{
         a++;
         NSLog(@"a的值==%d",a);
     };
     myBlock();
    //控制台输出结果：a的值==11
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
-(UIButton *)downloadImageBtn{
    if (!_downloadImageBtn) {
          _downloadImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
          [_downloadImageBtn setTitle:@"点击下载图片" forState:UIControlStateNormal];
          [_downloadImageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          _downloadImageBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:0.5];
          _downloadImageBtn.frame = CGRectMake(60, 330, [UIScreen mainScreen].bounds.size.width - 120, 40);
          _downloadImageBtn.backgroundColor = [UIColor orangeColor];
        [_downloadImageBtn addTarget:self action:@selector(downloadImageAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadImageBtn;
}
- (UIImageView *)myImgView{
    if (!_myImgView) {
        _myImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 380, [UIScreen mainScreen].bounds.size.width - 40, 200)];
        _myImgView.contentMode = UIViewContentModeScaleAspectFill;
        _myImgView.backgroundColor = [UIColor blueColor];
    }
    return _myImgView;
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
//点击下载图片
- (void)downloadImageAction:(id)sender{
    __weak typeof (self) weakSelf = self;
    NSString *urlStr = @"https://img95.699pic.com/photo/40011/0709.jpg_wh860.jpg";
    DownloadManager *downloadManager = [[DownloadManager alloc] init];
    [downloadManager downloadWithUrl:urlStr parameters:@{} hander:^(NSData * _Nonnull receiveData, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"下载失败：%@", error);
            weakSelf.downloadImageBtn.enabled = YES;
        }else{
            NSLog(@"下载成功：%@",receiveData);
            weakSelf.myImgView.image = [UIImage imageWithData:[NSData dataWithData:receiveData]];
            weakSelf.downloadImageBtn.enabled = NO;
        }
    }];
}

- (void)dealloc{
    NSLog(@"dealloc 来了！！");
}
@end
