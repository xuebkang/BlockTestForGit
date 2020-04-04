//
//  ViewController.h
//  Block--Demo
//
//  Created by 薛 on 2020/3/31.
//  Copyright © 2020 Xue. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIView *backgroundView;

- (void)startAnimating;
- (void)stopAnimating;
 

@end

