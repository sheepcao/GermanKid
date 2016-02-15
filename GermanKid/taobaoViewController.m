//
//  taobaoViewController.m
//  GermanKid
//
//  Created by Eric Cao on 1/25/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import "taobaoViewController.h"
#import "globalVar.h"
#import "topBarView.h"
#import "MBProgressHUD.h"

@interface taobaoViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webview;
@property (nonatomic,strong) topBarView *topBar;
@property (nonatomic,strong) MBProgressHUD *hud;
@end

@implementation taobaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.topBar = [[topBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.topBar.pagetitle setText:@"宝贝详情"];
    self.topBar.alpha = 1.0f;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 28, 40, 30)];
    [backBtn setTitle:@"后退" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backTap) forControlEvents:UIControlEventTouchUpInside];
    [self.topBar addSubview:backBtn];
    
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-55, 28, 40, 30)];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeTap) forControlEvents:UIControlEventTouchUpInside];
    [self.topBar addSubview:closeBtn];
    
    [self.view addSubview:self.topBar];
    
    
    
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.webview.delegate = self;
    self.webview.backgroundColor = [UIColor yellowColor];
    self.webview.scalesPageToFit = YES;
    

//    NSString *path = @"https://h5.m.taobao.com/awp/core/detail.htm?ft=t&id=524245383905";
    NSURL *url = [[NSURL alloc] initWithString:self.taobaoURL];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.webview];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"加载中...";
    [self.hud hide:YES afterDelay:2.3f];

    
}


-(void)backTap
{
    [self.webview goBack];
}
-(void)closeTap
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];

}

-(void)webViewDidStartLoad:(UIWebView *)webView{
[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
   
    NSLog(@"webViewDidStartLoad");
}
-(void)webViewDidFinishLoad{


    [self.hud hide:YES];
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
    NSLog(@"webViewDidFinishLoad");

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"didFailLoadWithError:%@",error);

    [ [UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
