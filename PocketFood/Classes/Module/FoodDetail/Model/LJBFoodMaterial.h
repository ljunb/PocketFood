//
//  LJBFoodMaterial.h
//  PocketFood
//
//  Created by ljunb on 15/11/20.
//  Copyright © 2015年 qf. All rights reserved.
//  食物材料与做法模型
/**
 *  "id": 468,
 "code": "guihuajiuniangyuanzi",
 "name": "桂花酒酿圆子",
 "image_url": "http://s.boohee.cn/house/upload_food/2009/1/9/190854_1231478479.jpg",
 "tips": "1.酒酿不要太早放入水中煮，否则加热时间过长会变酸。
 2.酒酿里还可以加鸡蛋，随自己喜好。
 3.酒酿是甜的，最后加的挂花蜜也是甜的。所以可以少加或不加糖
 4.加桂花蜜时，酒酿放温了再加，以免破坏桂花蜜的营养。",
 "condiments": [
 {
 "name": "水磨糯米粉",
 "amount": "100克"
 },
 {},
 {},
 {},
 {}
 ],
 "steps": [
 {
 "position": 1,
 "desc": "将糯米粉放入容器中，倒入温水，边倒边用筷子搅拌成面絮。",
 "image_url": "http://i1.douguo.net/upload/caiku/2/d/5/200_2d07505b1de88fe4099ac8caeafb2355.jpeg"
 },
 {},
 {},
 {}
 ]
 */

#import <Foundation/Foundation.h>

@class LJBMaterialCondiment;
@class LJBCookStep;

@interface LJBFoodMaterial : NSObject <MJKeyValue>
/**
 *  食物id
 */
@property (nonatomic, copy) NSString * food_id;

/**
 *  食物编码
 */
@property (nonatomic, copy) NSString * code;

/**
 *  食物名称
 */
@property (nonatomic, copy) NSString * name;

/**
 *  食物图片URL
 */
@property (nonatomic, copy) NSString * image_url;

/**
 *  食物做法贴士
 */
@property (nonatomic, copy) NSString * tips;

/**
 *  食物原料模型
 */
@property (nonatomic, strong) NSArray * condiments;

/**
 *  食物做法模型
 */
@property (nonatomic, strong) NSArray * steps;

@property (nonatomic, assign) CGFloat tipsHeight;

@end
