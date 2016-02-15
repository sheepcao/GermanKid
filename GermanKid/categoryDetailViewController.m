//
//  categoryDetailViewController.m
//  GermanKid
//
//  Created by Eric Cao on 2/3/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import "categoryDetailViewController.h"
#import "HFStretchableTableHeaderView.h"
#import "topBarView.h"
#import "globalVar.h"
#import "productTableViewCell.h"
#import "menuSrollView.h"
#import "detailViewController.h"

#define StretchHeaderHeight 220

@interface categoryDetailViewController ()
@property (nonatomic,strong) UITableView *mineTable;
@property (nonatomic,strong) HFStretchableTableHeaderView *stretchHeaderView;
@property (nonatomic,strong) topBarView *topBar;
@property (nonatomic, strong) NSMutableArray *prodArray;

@property (nonatomic, strong) NSArray *menuArray;

@property (nonatomic, strong) menuSrollView *menuScroll;
@property (nonatomic, strong) menuSrollView *fakeScroll;

@property int menuNow;

@end

@implementation categoryDetailViewController
@synthesize menuNow;

- (UITableView *)mineTable
{
    if (_mineTable == nil) {
        _mineTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width+2, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _mineTable.delegate = self;
        _mineTable.dataSource = self;
        _mineTable.showsVerticalScrollIndicator = NO;
        _mineTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mineTable.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];

        [self.view addSubview:_mineTable];
    }
    return _mineTable;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.prodArray = [[NSMutableArray alloc] initWithObjects:@"prod1",@"prod2",@"prod3",@"prod4",nil];
    NSArray *menuTitles = @[@"menu1",@"menu2",@"menu3",@"menu4",@"menu5",@"menu6",@"menu7",@"menu8"];
    self.menuArray = menuTitles;
    
    self.topBar = [[topBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.topBar.pagetitle setText:@"0-2岁"];
    self.topBar.alpha = 0.0f;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 28, 40, 30)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backTap) forControlEvents:UIControlEventTouchUpInside];
    [self.topBar addSubview:backBtn];
    
    [self mineTable];
    
    menuNow = 0;
    
    
    [self initStretchHeader];
    
    [self.view addSubview:self.topBar];
    
    [self.mineTable addObserver: self forKeyPath: @"contentOffset" options: NSKeyValueObservingOptionNew context: nil];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (self.mineTable.contentOffset.y<StretchHeaderHeight-64) {
        
        
        
        self.topBar.alpha = self.mineTable.contentOffset.y/(StretchHeaderHeight-64);
        
        [self.fakeScroll setHidden:YES];
        [self.menuScroll setHidden:NO];
        
        
    }else
    {
        [self.fakeScroll setHidden:NO];
        [self.menuScroll setHidden:YES];
        
        self.topBar.alpha = 1.0f;
    }
    
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
    bgImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"prod3" ofType:@"jpg"]];
    
    //背景之上的内容
    UIView *contentView = [[UIView alloc] initWithFrame:bgImageView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    
    
    
    self.stretchHeaderView = [HFStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self.mineTable withView:bgImageView subViews:contentView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView             // Default is 1 if not implemented
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 40;
        
    }else
    {
        return SCREEN_WIDTH/2+56;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.prodArray.count+1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *cellId = @"reuseCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId ];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.menuScroll = [[menuSrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            self.menuScroll.contentSize=CGSizeMake(700,40);
            
            
            [self.menuScroll setupCategory:self.menuArray];
            
            
            for (UIView *subview in [self.menuScroll subviews]) {
                if ([subview isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)subview;
                    
                    [btn addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
            }
            
            [self.menuScroll scrollToPage:menuNow];
            
            [cell addSubview:self.menuScroll];
            

        }
        
        if (!self.fakeScroll) {
            
            self.fakeScroll = [[menuSrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
            self.fakeScroll.contentSize=CGSizeMake(700,40);
            
            
            [self.fakeScroll setupCategory:self.menuArray];
            
            for (UIView *subview in [self.fakeScroll subviews]) {
                if ([subview isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)subview;
                    
                    [btn addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
            }
            
            [self.view addSubview:self.fakeScroll];
            [self.fakeScroll setHidden:YES];
            [self.fakeScroll scrollToPage:menuNow];
            
        }

        
       
        

        return cell;
        
    }else
    {
        
        NSLog(@"load cell...-==================");
        
        productTableViewCell *prodCell =(productTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"productTableViewCell"];
        if (nil == prodCell)
        {
            prodCell = [[[NSBundle mainBundle]loadNibNamed:@"productTableViewCell" owner:self options:nil] objectAtIndex:0];//加载nib文件
            prodCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
            UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
            
            leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
            rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
            
            [self.view addGestureRecognizer:leftSwipeGestureRecognizer];
            [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
        }
        
        
        
        NSInteger rowNow = indexPath.row -1;
        
        NSString *prodName = [NSString stringWithFormat:@"%@.jpg",self.prodArray[rowNow]];
        
        [prodCell.productImageOne setImage:[UIImage imageNamed:prodName]];
        [prodCell.prodButtonOne addTarget:self action:@selector(prodTapped:) forControlEvents:UIControlEventTouchUpInside];
        prodCell.prodButtonOne.tag = rowNow*2;
        
        [prodCell.productImageTwo setImage:[UIImage imageNamed:prodName]];
        [prodCell.prodButtonTwo addTarget:self action:@selector(prodTapped:) forControlEvents:UIControlEventTouchUpInside];
        prodCell.prodButtonTwo.tag = rowNow+1;
        
        UIView *dismissingView = [[UIView alloc] initWithFrame:prodCell.frame];
        dismissingView.backgroundColor = [UIColor whiteColor];
        dismissingView.alpha = 0.8f;
        [prodCell addSubview:dismissingView];
        
        
        [UIView animateWithDuration:0.85f animations:^(void){
            
            dismissingView.alpha = 0.0f;
            
        } completion:^(BOOL isfinished){
            
            [dismissingView removeFromSuperview];
            
        }];
        
        
        return prodCell;
    }
    
}

-(void)segmentedControlChangedValue:(UIButton *)sender
{
    NSLog(@"sender:%lu",sender.tag);
    menuNow =sender.tag - 100;
    [self.menuScroll scrollToPage:(sender.tag - 100)];
    [self.fakeScroll scrollToPage:(sender.tag - 100)];

    NSIndexSet *indexSet1 = [[NSIndexSet alloc] initWithIndex: 0];

    [self.mineTable reloadSections:indexSet1 withRowAnimation:UITableViewRowAnimationFade];
    
    if (self.mineTable.contentOffset.y >= (StretchHeaderHeight-64)) {
        [self.mineTable setContentOffset:CGPointMake(0, StretchHeaderHeight-64)];
        
    }
    
}

-(void)prodTapped:(UIButton *)sender
{
    
    NSLog(@"product tapped:%lu",sender.tag);
    
    detailViewController *detailView = [[detailViewController alloc] initWithNibName:@"detailViewController" bundle:nil];
    //    [self.view.window.rootViewController presentViewController:detailView animated:YES completion:nil];
    
    [self.navigationController pushViewController:detailView  animated:YES];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    //    [self.mainTableView reloadData];
    NSIndexSet *indexSet1 = [[NSIndexSet alloc] initWithIndex: 0];

    
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (menuNow<self.menuArray.count-1) {
            [self.menuScroll scrollToPage:(menuNow +1)];
            [self.fakeScroll scrollToPage:(menuNow +1)];
            menuNow++;
            [self.mineTable reloadSections:indexSet1 withRowAnimation:UITableViewRowAnimationFade];
            if (self.mineTable.contentOffset.y >= (StretchHeaderHeight-64)) {
                [self.mineTable setContentOffset:CGPointMake(0, StretchHeaderHeight-64)];
                
            }
            
        }
        
        
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        if (menuNow>0) {
            [self.menuScroll scrollToPage:(menuNow -1)];
            [self.fakeScroll scrollToPage:(menuNow- 1)];
            menuNow--;
            [self.mineTable reloadSections:indexSet1 withRowAnimation:UITableViewRowAnimationFade];
            if (self.mineTable.contentOffset.y >= (StretchHeaderHeight-64)) {
                [self.mineTable setContentOffset:CGPointMake(0, StretchHeaderHeight-64)];
                
            }
        }
        
    }
    
}
-(void)dealloc
{
    [self.mineTable removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark - stretchableTable delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
}


- (void)viewDidLayoutSubviews
{
    [self.stretchHeaderView resizeView];
}


@end
