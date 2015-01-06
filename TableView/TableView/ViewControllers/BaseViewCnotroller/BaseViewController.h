//
//  BaseViewController.h
//  TableView
//
//  Created by shadow on 2015/1/6.
//  Copyright (c) 2015年 shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Global.h"


/******   Pod   ******/
#import <AFNetworking/AFNetworking.h>
/******   Pod   ******/

typedef void (^ApiCallback)(id result, NSError *error);//API Call Back的Block方法


@interface BaseViewController : UIViewController

-(void)getAPIData:(NSString *)urlString parameters:(NSDictionary *)parameters callback:(ApiCallback)callback;

@end
