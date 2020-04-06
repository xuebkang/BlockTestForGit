//
//  DownloadManager.h
//  Block--Demo
//
//  Created by 薛 on 2020/4/6.
//  Copyright © 2020 Xue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//定义block
typedef void(^DownloadManagerBlock) (NSData *receiveData, NSError *error);

@interface DownloadManager : NSObject<NSURLSessionDownloadDelegate>

//@property (nonatomic, copy) DownloadManagerBlock downLoadBlock;
//定义方法
- (void)downloadWithUrl:(NSString *)Url parameters:(NSDictionary *)parameters hander:(DownloadManagerBlock )hander;
@end

NS_ASSUME_NONNULL_END
