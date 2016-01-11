//
//  LJBTopicPageFrame.m
//  PocketFood
//
//  Created by qf on 15/11/18.
//  Copyright © 2015年 qf. All rights reserved.
//

#import "LJBTopicPageFrame.h"
#import "LJBTopicPage.h"

@implementation LJBTopicPageFrame

- (void)setModel:(LJBTopicPage *)model {
    
    _model = model;
    
    _contentHeight = [model.Description boundingRectWithSize:CGSizeMake(KScreenSize.width-10*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + KScreenSize.height*0.4 + 110;
}

@end
