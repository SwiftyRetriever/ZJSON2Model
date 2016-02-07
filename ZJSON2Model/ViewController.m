//
//  ViewController.m
//  ZJSON2Model
//
//  Created by ZERO. on 14/11/19.
//  Copyright (c) 2014年 ZERO. All rights reserved.
//

#import "ViewController.h"
#import "JSONObject.h"
#import "ZJSON2Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id JSON = @{@"id": @"9529", @"name": @"JSOName", @"arr": @[@"1", @"2"], @"json": @{@"name": @"json_name"}};
    JSONObject *obj = [JSONObject objectWithJSONObject:JSON];
    
    NSLog(@"%@", [obj toJSONString]);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
