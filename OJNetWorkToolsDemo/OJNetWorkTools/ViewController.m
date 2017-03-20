//
//  ViewController.m
//  OJNetWorkTools
//
//  Created by OneJ on 2017/3/17.
//  Copyright © 2017年 Onej. All rights reserved.
//

#import "ViewController.h"
#import "OJNetWorkTools.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlStr;
    NSDictionary *dict;
    //使用get请求
    [[OJNetWorkTools shareRequestData] requestDataURL:urlStr parameters:dict method:GET success:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        
    } fail:^(NSError *error) {
        
    }];
    
    //使用post请求
    [[OJNetWorkTools shareRequestData] requestDataURL:urlStr parameters:dict method:POST success:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        
    } fail:^(NSError *error) {
        
    }];
    
    //直接解析json
    [[OJNetWorkTools shareRequestData] requestDataURL:urlStr parameters:dict method:POST dataFormat:JSON success:^(id data, NSURLResponse *response) {
        NSLog(@"%@",data);
    } fail:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
