//
//  NSArray+ZJSON2Model.h
//  ZJSON2Model
//
//  Created by ZERO. on 16/1/30.
//  Copyright © 2016年 ZERO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ZJSON2Model)

+ (id) arrayWithJSONArray:(id)JSONArray class:(Class)aClass;

@end
