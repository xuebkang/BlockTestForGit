//
//  DownloadManager.m
//  Block--Demo
//
//  Created by 薛 on 2020/4/6.
//  Copyright © 2020 Xue. All rights reserved.
//

#import "DownloadManager.h"

@interface DownloadManager ()

@end

@implementation DownloadManager

//下面通过封装NSURLSession的请求，传入一个处理请求结果的block对象，就会自动将请求任务放到工作线程中执行实现，我们在网络请求逻辑的代码中调用如下：
- (void)downloadWithUrl:(NSString *)Url parameters:(NSDictionary *)parameters hander:(DownloadManagerBlock )hander{
     
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:Url]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    //执行请求任务
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (hander) {
            dispatch_async(dispatch_get_main_queue(), ^{
                hander(data, error);
            });
        }
    }];
    [task resume];
    
}
- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    
}

@end
