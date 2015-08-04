//
//  ViewController.h
//  GetListDemo
//
//  Created by Apple on 8/4/15.
//  Copyright (c) 2015 华讯网络投资有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "listViewController.h"
#import "singleManager.h"
@interface ViewController : UIViewController
{
       UIButton *loginButton;
}

// 当前标签的名字 ,currentTagName 用于存储正在解析的元素名
@property (strong ,nonatomic) NSString * currentTagName;

@property (strong,nonatomic) NSMutableArray * array;

@end

