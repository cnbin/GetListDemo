//
//  listViewController.h
//  GetListDemo
//
//  Created by Apple on 8/4/15.
//  Copyright (c) 2015 华讯网络投资有限公司. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "singleManager.h"
@interface listViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
}

@property (nonatomic,strong) UILabel * labelText;
@end
