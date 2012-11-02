//
//  User.h
//  SaveMoney
//
//  Created by HARADA SHINYA on 10/28/12.
//  Copyright (c) 2012 HARADA SHINYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPClient.h>
#import <AFJSONRequestOperation.h>
#import <AFNetworking.h>


@interface User : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>
+(id)shared;
-(NSString *)uuid;
-(void)create;

@end
