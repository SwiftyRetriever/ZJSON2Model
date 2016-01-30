//
//  NSObject+ZJSON2Model.h
//  ZJSON2Model
//
//  Created by ZERO. on 16/1/30.
//  Copyright © 2016年 ZERO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZJSON2Model)

- (id)toJSONObject;

- (id)toJSONString;

+ (id)properties;

+ (id)objectWithJSONData:(id)JSONData;

+ (id)objectWithJSONString:(id)JSONString;

+ (id)objectWithJSONObject:(id)JSONObject;


@end
