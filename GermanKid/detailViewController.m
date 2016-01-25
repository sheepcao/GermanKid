//
//  detailViewController.m
//  GermanKid
//
//  Created by Eric Cao on 1/25/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import "detailViewController.h"
#import "HFStretchableTableHeaderView.h"
#import "topBarView.h"
#import "globalVar.h"
#define StretchHeaderHeight 200

@interface detailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *mineTable;
@property (nonatomic,strong) HFStretchableTableHeaderView *stretchHeaderView;
@property (nonatomic,strong) topBarView *topBar;

@end

@implementation detailViewController

- (UITableView *)mineTable
{
    if (_mineTable == nil) {
        _mineTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width+2, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _mineTable.delegate = self;
        _mineTable.dataSource = self;
        _mineTable.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_mineTable];
    }
    return _mineTable;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.topBar = [[topBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.topBar.pagetitle setText:@"细嗅精华"];
    self.topBar.alpha = 0.0f;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 28, 40, 30)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backTap) forControlEvents:UIControlEventTouchUpInside];
    [self.topBar addSubview:backBtn];
    
   
    

    
    
    [self mineTable];
    
    [self initStretchHeader];
    
    [self.view addSubview:self.topBar];
    
}
-(void)backTap
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)initStretchHeader
{
    //背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width+2, StretchHeaderHeight)];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    bgImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image1" ofType:@"jpg"]];
    
    //背景之上的内容
    UIView *contentView = [[UIView alloc] initWithFrame:bgImageView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    
    /*
     UIImageView *avater = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
     avater.image = [UIImage imageNamed:@"avater"];
     avater.center = contentView.center;
     [contentView addSubview:avater];
     */
    
    self.stretchHeaderView = [HFStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self.mineTable withView:bgImageView subViews:contentView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"reuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId ];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - stretchableTable delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
    
    
    if (scrollView.contentOffset.y<(SCREEN_HEIGHT/2))
    {
        

        self.topBar.alpha = scrollView.contentOffset.y/(SCREEN_HEIGHT/2);
        
        
        
    }else
    {
        self.topBar.alpha = 1.0f;
    }
}

- (void)viewDidLayoutSubviews
{
    [self.stretchHeaderView resizeView];
}
@end
