//
//  listViewController.m
//  GetListDemo
//
//  Created by Apple on 8/4/15.
//  Copyright (c) 2015 华讯网络投资有限公司. All rights reserved.
//

#import "listViewController.h"

@interface listViewController ()

@end

@implementation listViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)initView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height)];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView reloadData];
    
    for (NSObject *object in [singleManager sharedInstance].shareArrayTag) {
        NSLog(@"数组对象11:%@", object);
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell;
    NSInteger row = indexPath.row;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        _labelText=[[UILabel alloc]initWithFrame:CGRectMake(45, 4, 180, 34)];
        _labelText.font=[UIFont fontWithName:@"Helvetica" size:16];
        _labelText.text =[[singleManager sharedInstance].shareArrayTag objectAtIndex:row];
        [cell.contentView addSubview:_labelText];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
