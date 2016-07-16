//
//  RCTSimpleFetch.h
//  RCTSimpleFetch
//
//  Created by ShenTong on 16/7/15.
//  Copyright © 2016年 Liaoyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"
#import "RCTConvert.h"
#import "RCTLog.h"


@interface RCTSimpleFetch : NSObject <RCTBridgeModule>


@property NSURLSession *defaultSession;


@end
