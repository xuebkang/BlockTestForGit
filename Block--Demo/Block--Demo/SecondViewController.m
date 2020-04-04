//
//  SecondViewController.m
//  Block--Demo
//
//  Created by 薛 on 2020/3/31.
//  Copyright © 2020 Xue. All rights reserved.
//

#import "SecondViewController.h"
typedef void (^MyBlock)(void);

typedef void (^MyBlock2)(SecondViewController *);
@interface SecondViewController ()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) MyBlock myBlock;
@property (nonatomic, copy) MyBlock2 myBlock2;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二页";
    self.view.backgroundColor = [UIColor whiteColor];
    self.name = @"我叫Block";
    //第四种解决block循环引用的问题， 换种方法是用 self
    self.myBlock2 = ^(SecondViewController *vc) {
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   NSLog(@"我的名字:%@", vc.name);
               });
           };
    self.myBlock2(self);
    
    //__block 修饰的变量可以在block里面进行改变，从栈copy到堆
    __block int a = 10;
    self.myBlock = ^{
        a++;
        NSLog(@"A=%d", a);
    }; 
    self.myBlock();
}

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
- (void)dealloc{
    NSLog(@"dealloc 来了！！");
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
