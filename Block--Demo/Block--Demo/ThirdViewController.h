//
//  ThirdViewController.h
//  Block--Demo
//
//  Created by 薛 on 2020/4/6.
//  Copyright © 2020 Xue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^Myblock)(NSString *string);
@interface ThirdViewController : UIViewController
@property (nonatomic, copy) Myblock myBlock;

@end

NS_ASSUME_NONNULL_END
