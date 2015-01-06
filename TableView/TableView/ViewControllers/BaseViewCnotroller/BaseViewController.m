//
//  BaseViewController.m
//  TableView
//
//  Created by shadow on 2015/1/6.
//  Copyright (c) 2015年 shadow. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 取得API資料
-(void)getAPIData:(NSString *)urlString parameters:(NSDictionary *)parameters callback:(ApiCallback)callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //*************** JSON格式的參數 ***************//
    
    [manager setRequestSerializer:[AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted]];
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject[%@]", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(nil, error);

    }];
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
