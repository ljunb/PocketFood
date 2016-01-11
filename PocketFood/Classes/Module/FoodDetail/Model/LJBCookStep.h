//
//  LJBCookStep.h
//  PocketFood
//
//  Created by qf on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//  做法步骤
/**
 *   "steps": [
 {
 "position": 1,
 "desc": "将糯米粉放入容器中，倒入温水，边倒边用筷子搅拌成面絮。",
 "image_url": "http://i1.douguo.net/upload/caiku/2/d/5/200_2d07505b1de88fe4099ac8caeafb2355.jpeg"
 */

#import <Foundation/Foundation.h>


@interface LJBCookStep : NSObject

@property (nonatomic, copy) NSString * position;

@property (nonatomic, copy) NSString * desc;

@property (nonatomic, copy) NSString * image_url;

@property (nonatomic, assign) CGFloat descHeight;

@end
