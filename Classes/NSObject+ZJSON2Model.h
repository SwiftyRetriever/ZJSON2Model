//
//  NSObject+ZJSON2Model.h
//  ZJSON2Model
//
//  Created by ZERO. on 16/1/30.
//  Copyright © 2016年 ZERO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZJSON2Model)

/**
 *  from a NSObject mapped to JSONObject.
 *
 *  @return A JSONObject
 */
- (id)toJSONObject;

/**
 *  from a NSObject mapped to JSONString.
 *
 *  @return A sting
 */
- (id)toJSONString;

/**
 *  NSObject properties
 *
 *  @return An Array contain all object properties
 */
+ (id)properties;

/**
 *  from a JSONData mapped to NSObject
 *
 *  @param JSONData A standard JSONData
 *
 *  @return A NSObject
 */
+ (id)objectWithJSONData:(id)JSONData;

/**
 *  from a JSONString mapped to NSObject
 *
 *  @param JSONString A standard JSONString
 *
 *  @return A NSObject
 */
+ (id)objectWithJSONString:(id)JSONString;


/**
 *  from a JSONObject mapped to NSObject 
 *  support most objective-c type
 *
 *  @param JSONObject A standard JSONObject.
 *
 *  @return A NSObject
 */
+ (id)objectWithJSONObject:(id)JSONObject;


@end
