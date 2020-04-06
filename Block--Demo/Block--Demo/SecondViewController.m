//
//  SecondViewController.m
//  Block--Demo
//
//  Created by 薛 on 2020/3/31.
//  Copyright © 2020 Xue. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
typedef void (^MyBlock)(void);
typedef void (^MyBlock2)(SecondViewController *);
//typedef 定义有参数有返回值的block
typedef int (^MyBlock3)(int c, int d);

@interface SecondViewController ()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) MyBlock myBlock;
@property (nonatomic, copy) MyBlock2 myBlock2;

//block 修饰 作为属性
@property (nonatomic, copy) MyBlock3 threeBlock;

@property (nonatomic, copy) int (^sum)(int, int); // 不使用 typedef

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UILabel  *label1;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二页";
    self.view.backgroundColor = [UIColor whiteColor];
    self.name = @"我叫Block";
    [self.view addSubview:self.button1];
    [self.view addSubview:self.label1];
    

    
    // 声明静态局部变量global
   static int global = 100;

    void(^myBlock2)(void) = ^{
        NSLog(@"global = %d", global);
    };
    // 调用后控制台输出"global = 100"
    myBlock2();
    
    //作为方法调用block
    [self testTimeConsume:^{
        
    }];
    //调用方法
    [self testBlockWith:^(NSString *name) {
        // 放入 block 中的代码，可以使用参数 name
        // 参数 name 是实现代码中传入的，在调用时只能使用，不能修改
        NSLog(@"block传递过来的参数为：%@", name);
    }];
}
- (UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, [UIScreen mainScreen].bounds.size.width - 40, 100)];
        _label1.backgroundColor = [UIColor lightGrayColor];
        _label1.numberOfLines = 0;
        _label1.font = [UIFont systemFontOfSize:13 weight:0.5];
    }
    return _label1;
}
-(UIButton *)button1{
    if (!_button1 ) {
          _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
          [_button1 setTitle:@"进入界面3" forState:UIControlStateNormal];
          [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          _button1.titleLabel.font = [UIFont systemFontOfSize:15 weight:0.5];
          _button1.frame = CGRectMake(60, 90, [UIScreen mainScreen].bounds.size.width - 120, 40);
          _button1.backgroundColor = [UIColor orangeColor];
        [_button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}
- (void)button1Action:(id)sender{
    //block反向传值实例
    ThirdViewController *thirdVc = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:thirdVc animated:YES];
    __weak typeof (self) weakSelf = self;
    //用属性定义的注意：这里属性是不会自动补全的，方法就会自动补全
    [thirdVc setMyBlock:^(NSString * string) {
        weakSelf.label1.text = string;
    }];
    
}

//Block的使用示例****************************************************

//Block作为变量（Xcode快捷键：inlineBlock）
- (void)demo8{
    int(^sumBlock)(int, int);
    sumBlock = ^(int s, int d){
        return s + d;
    };
    int f = sumBlock(10, 20);
    NSLog(@"f的值为=%d", f);
 //如下代码等同于上
    int(^sum)(int, int) = ^(int d, int j) {
        int dd = d + j;
        NSLog(@"dd的值为: %d", dd);
        return dd;
    };
    sum(30, 50);
}

//Block作为属性（Xcode 快捷键：typedefBlock）
- (void)demo9{
    //使用block
      self.threeBlock = ^int(int c, int d) {
          NSLog(@"block的返回值 == %d",c*d);

          return c*d;
      };
      self.threeBlock(10, 20);
    
    //以下是不使用typedef 定义的block 属性

    self.sum = ^int(int b, int c) {
        return (b + c);
    };
    self.sum(3, 49);
}
//  Block 修改局部变量***********************************
- (void)demo5{
    //__block 修饰的变量可以在block里面进行改变，从栈copy到堆
     //会发现一个局部变量加上block修饰符后竟然跟block一样变成了一个Block_byref_val_0结构体类型的自动变量实例！！！！
     __block int a = 10;
     self.myBlock = ^{
         a++;
         NSLog(@"A=%d", a);
     };
     self.myBlock();
}
// Block作为 OC 中的方法参数

// ---- 无参数传递的 Block ---------------------------//
- (CGFloat)testTimeConsume:(void(^)(void))middleBlock{
    //执行前记录当前时间
    CFTimeInterval startTime = CACurrentMediaTime();
    middleBlock();
    //执行后记录当前时间
    CFTimeInterval endTime = CACurrentMediaTime();
    NSLog(@"时间差为：%f", endTime - startTime);
    return endTime - startTime;
   
}
// ---- 有参数传递的 Block ---------------------------//
- (NSString *)testBlockWith:(void(^)(NSString *name))testBlock{
    NSString *name = @"我是block传递的参数";
    testBlock(name);
    return name;
}


//Block常用写法*************************************************//

//无参无返回值的
- (void)blockWriteStyle1{
    //无参无返回值的
     void (^myBlock2) (void) = ^{
         NSLog(@"无参无返回Block");
     };
     myBlock2();
}
    
//有参无返回值block
- (void)blockWriteStyle2{
    void (^myBlock3) (int a) = ^(int a){
        NSLog(@"a == %d, 我就是有参数无返回值得block", a);
    };
    //调用block
    myBlock3(100);
}
//有参有返回值的block
- (void)blockWriteStyle3{
    //有参有返回值的block
    int (^myBlock4)(int , int) = ^(int a, int b){
        NSLog(@"-- %d, 我就是有参 有返回值的block", a +b);
        return (a +b);
    };
    //调用block
    myBlock4(30 , 20);
}
//无参数有返回值的block（实际中很少用到）
- (void)blockWriteStyle4{
    //无参有返回值的block
     int (^myBlock5)(void) = ^{
         NSLog(@"我是一个无参数， 有返回值的block");
         return 100;
     };
     myBlock5();
}
//******************************解决block循环的方法*************//

//一般解决block循环的方法 __weak
- (void)demo1{
    __weak typeof (self) weakSelf = self;
    //使用block
    self.myBlock = ^{
        NSLog(@"我的名字:%@", weakSelf.name);
    };
    self.myBlock();
}

//block嵌套情况下解决循环问题
- (void)demo2{
    __weak typeof (self) weakSelf = self;
    //数据丢失 ———>释放self --->nil
    //nil -->getter -->nil
    self.myBlock = ^{
        //解决block嵌套循环方法
        __strong typeof (self) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"我的名字:%@", strongSelf.name);
        });
    };
    self.myBlock();
}
//第三种防止block循环
- (void)demo3{
    //self -->block -->vc(nil)-->self
     __block SecondViewController *vc = self;
     self.myBlock = ^{
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSLog(@"我的名字:%@", vc.name);
             vc = nil;
                
         });
     };
     self.myBlock();
}
//第四种解决block循环引用的问题， 换种方法是用 self

- (void)demo4{
    self.myBlock2 = ^(SecondViewController *vc) {
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   NSLog(@"我的名字:%@", vc.name);
               });
           };
    self.myBlock2(self);
    
}

- (void)dealloc{
    NSLog(@"dealloc 来了！！");
}


@end
