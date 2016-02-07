//
//  JSONObject.h
//  ZJSON2Model
//
//  Created by ZhangZZZZ on 16/1/30.
//  Copyright © 2016年 ZERO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSON : NSObject

@property (strong, nonatomic) NSString *name;

@end

@interface JSONObject : NSObject

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *arr;
@property (strong, nonatomic) NSDictionary *dict;
@property (strong, nonatomic) JSON *json;
@property (strong, nonatomic) NSArray<JSON *> *jsonArray;

@end
