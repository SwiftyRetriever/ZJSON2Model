//
//  NSObject+ZJSONMapper.h
//  ZJSON2Model
//
//  Created by ZhangZZZZ on 16/1/30.
//  Copyright © 2016年 ZERO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZJSONMapper)

/**
 *  from JSONObject Key map to Object propertyName
 *
 *  @return @{ObjectKey : JSONKey}
 */

+ (id)JSONMapper;

@end
