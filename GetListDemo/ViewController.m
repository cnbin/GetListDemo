//
//  ViewController.m
//  GetListDemo
//
//  Created by Apple on 8/4/15.
//  Copyright (c) 2015 华讯网络投资有限公司. All rights reserved.
//

#import "ViewController.h"
#import "NSString+URLEncoding.h"
#import "listViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"加载首页信息";
    _array =[[NSMutableArray alloc]init];
    loginButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame=CGRectMake(20, 80, 280, 30);
    [loginButton setTitle:@"测试" forState:UIControlStateNormal];
    [loginButton.layer setBorderWidth:1.0];
    [loginButton.layer setBorderColor:(__bridge CGColorRef)([UIColor greenColor])];//边框颜色;
    [self.view addSubview:loginButton];
    [loginButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    [self startRequest];
}

- (void) buttonAction:(UIButton *)button{
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[listViewController alloc] init]] animated:YES completion:nil];

}

-(void)startRequest{
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://192.168.40.10/Login/login.asmx"];
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    NSString * envelopeText = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               "<soap:Body>"
                               "<GetlistInfo xmlns=\"http://tempuri.org/\" />"
                               "</soap:Body>"
                               "</soap:Envelope>"];
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [envelope length]] forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request delegate:self];
    
    if (connection) {
    }
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    //     NSLog(@"开始解析文档");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //      NSLog(@"结束解析文档");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    //把elementName 赋值给 成员变量 currentTagName
    _currentTagName  = elementName ;
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    string  = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""]) {
        return;
    }
    NSLog(@"string is %@",string);
    [_array addObject: string];
}

#pragma mark- NSURLConnection 回调方法
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    
}

-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
    
    NSLog(@"%@",[error localizedDescription]);
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
    
    
    NSLog(@"请求完成...");
    for (NSObject *object in _array) {
        NSLog(@"数组对象:%@", object);
    }
    [singleManager sharedInstance].shareArrayTag = _array ;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


