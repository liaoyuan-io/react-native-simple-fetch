//
//  RCTSimpleFetch.m
//  RCTSimpleFetch
//
//  Created by ShenTong on 16/7/15.
//  Copyright © 2016年 Liaoyuan. All rights reserved.
//

#import "RCTSimpleFetch.h"

@implementation RCTSimpleFetch

RCT_EXPORT_MODULE();

-(id)init {
    self = [super init];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    return self;
}


RCT_EXPORT_METHOD(sendRequest:(NSDictionary *)options resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    
    NSURL *url = [RCTConvert NSURL:options[@"url"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    BOOL gzipRequest = [RCTConvert BOOL:options[@"gzipRequest"]];
    
    request.HTTPMethod = [RCTConvert NSString:options[@"method"]];
    request.allHTTPHeaderFields = [RCTConvert NSDictionary:options[@"headers"]];
    request.timeoutInterval = [RCTConvert NSTimeInterval:options[@"timeout"]];
    [request setValue:@"gzip,deflate,sdch" forHTTPHeaderField:@"Accept-Encoding"];
    
    NSString *body = [[RCTConvert NSString:options[@"body"]] dataUsingEncoding:NSUTF8StringEncoding];
    if(gzipRequest) {
        request.HTTPBody = RCTGzipData(body, -1);
        [request setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    } else {
        request.HTTPBody = body;
    }
    [request setValue:(@(request.HTTPBody.length)).description forHTTPHeaderField:@"Content-Length"];
    
    [[self.defaultSession
      dataTaskWithRequest:request
      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
          
          NSMutableArray *result = [[NSMutableArray alloc] init];
          
          if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
              NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
              [result addObject:[NSString stringWithFormat:@"%d", (int)statusCode]];
          } else {
              [result addObject: @"-1"];
          }
          
          [result addObject:[[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding]];
          if(error == nil) {
              resolve(result);
          } else {
              reject(@"RequestError", response, error);
          }
      }] resume];
}

@end
