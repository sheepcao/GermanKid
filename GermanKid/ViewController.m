//
//  ViewController.m
//  GermanKid
//
//  Created by Eric Cao on 1/19/16.
//  Copyright © 2016 sheepcao. All rights reserved.
//

#import "ViewController.h"
#import "KDCycleBannerView.h"
#import "menuSrollView.h"
#import "topTableViewCell.h"
#import "productTableViewCell.h"
#import "TestTableViewController.h"
#import "CAPSPageMenu.h"
#import "topBarView.h"
#import "categoryView.h"
#import "detailViewController.h"



@interface ViewController ()<KDCycleBannerViewDataSource, KDCycleBannerViewDelegate,UIScrollViewDelegate,scrollEnableDelegate>

@property (nonatomic, strong) NSMutableArray *prodArray;
@property (nonatomic, strong) menuSrollView *menuScroll;

@property (strong, nonatomic) KDCycleBannerView *cycleBannerViewTop;
@property (nonatomic,strong) CAPSPageMenu *pageMenu;
@property (nonatomic,strong) NSMutableArray *controllerArray;
@property (nonatomic,strong) topBarView *topBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.prodArray = [[NSMutableArray alloc] initWithObjects:@"prod1",@"prod2",@"prod3",@"prod4",nil];
    
    NSArray *menuTitles = @[@"menu1",@"menu2",@"menu3",@"menu4",@"menu5",@"menu6",@"menu7",@"menu8"];

    self.navigationController.navigationBarHidden = YES;
    self.topBar = [[topBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.topBar.pagetitle setText:@"德国儿童用品"];
    self.topBar.alpha = 0.0f;
    [self.view addSubview:self.topBar];
    
    
    
    
    
    _cycleBannerViewTop = [KDCycleBannerView new];
    _cycleBannerViewTop.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_WIDTH/2);
    _cycleBannerViewTop.datasource = self;
    _cycleBannerViewTop.delegate = self;
    _cycleBannerViewTop.continuous = YES;
    _cycleBannerViewTop.autoPlayTimeInterval = 5;
    
    [self.mainScroll setContentSize:CGSizeMake(SCREEN_WIDTH, _cycleBannerViewTop.frame.size.height+categoryViewHeight+SCREEN_HEIGHT-44)];
    self.mainScroll.delegate = self;
    
    [self.mainScroll addSubview:_cycleBannerViewTop];
    
    ///////////////////////////////////
    
    
    categoryView *categories = [[categoryView alloc] initWithFrame:CGRectMake(0, _cycleBannerViewTop.frame.size.height, SCREEN_WIDTH, categoryViewHeight)];
    [categories.firstBtn addTarget:self action:@selector(categoryTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainScroll addSubview:categories];
    
    ///////////////////////////
    
    
    self.controllerArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<menuTitles.count; i++) {
        TestTableViewController *controller = [[TestTableViewController alloc]initWithNibName:@"TestTableViewController" bundle:nil];
        controller.title = menuTitles[i];
        controller.scrollDelegate = self;
        
        
        [self.controllerArray addObject:controller];
    }
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor colorWithRed:242.0/255.0 green:242/255.0 blue:242/255.0 alpha:1.0],
                                 CAPSPageMenuOptionViewBackgroundColor: [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0],
                                 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor colorWithRed:255/255.0 green:58/255.0 blue:61/255.0 alpha:1.0],
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0],
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor: [UIColor colorWithRed:255/255.0 green:58/255.0 blue:61/255.0 alpha:1.0],
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0],
                                 CAPSPageMenuOptionMenuItemFont: [UIFont fontWithName:@"HelveticaNeue" size:13.0],
                                 CAPSPageMenuOptionMenuHeight: @(35.0),
                                 CAPSPageMenuOptionMenuItemWidth: @(70.0),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES)
                                 };
    
    
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:self.controllerArray frame:CGRectMake(0.0, _cycleBannerViewTop.frame.size.height+categoryViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64) options:parameters];


    
    
    TestTableViewController *listControllerNow = self.controllerArray[self.pageMenu.currentPageIndex];
    [listControllerNow.tableView setScrollEnabled:NO];
    [self.mainScroll setScrollEnabled:YES];
    

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidLayoutSubviews
{
    [self.mainScroll addSubview:_pageMenu.view];
    
    if (SCREEN_MAX_LENGTH>700) {
        
        [self.LeftDistance setConstant:-20];
        [self.rightDistance setConstant:-20];
        [self.mainScroll setNeedsUpdateConstraints];
        

        [self.view setNeedsUpdateConstraints];
        [self.view layoutIfNeeded];

    }

}

-(void)categoryTap:(UIButton *)sender
{
    detailViewController *detailVC = [[detailViewController alloc] initWithNibName:@"detailViewController" bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - KDCycleBannerViewDataSource

- (NSArray *)numberOfKDCycleBannerView:(KDCycleBannerView *)bannerView {
    
    return @[[UIImage imageNamed:@"image1.jpg"],
             [UIImage imageNamed:@"image2.png"],
             @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=5ad7fab780025aafd33279cbcfd5aa64/8601a18b87d6277f15eb8e4f2a381f30e824fcc8.jpg",
             @"http://e.hiphotos.baidu.com/image/w%3D2048/sign=df5d0b61cdfc1e17fdbf8b317ea8f703/0bd162d9f2d3572c8d2b20ab8813632763d0c3f8.jpg",
             @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=a11d7b94552c11dfded1b823571f63d0/eaf81a4c510fd9f914eee91e272dd42a2934a4c8.jpg"];
}

- (UIViewContentMode)contentModeForImageIndex:(NSUInteger)index {
    return UIViewContentModeScaleAspectFill;
}

- (UIImage *)placeHolderImageOfZeroBannerView {
    return [UIImage imageNamed:@"image1"];
}

#pragma mark - KDCycleBannerViewDelegate

- (void)cycleBannerView:(KDCycleBannerView *)bannerView didScrollToIndex:(NSUInteger)index {
    NSLog(@"didScrollToIndex~~~~~~~~~~:%ld", (long)index);
}

- (void)cycleBannerView:(KDCycleBannerView *)bannerView didSelectedAtIndex:(NSUInteger)index {
    NSLog(@"didSelectedAtIndex:%ld", (long)index);
}


//
//#pragma mark -
//#pragma mark Table view delegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{    if (indexPath.section ==0) {
//    return SCREEN_WIDTH/2+60;
//}else
//{
//    return SCREEN_WIDTH/2+70;
//}
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 0;
//    }else
//    {
//        return 40;
//    }
//}
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//}
//
//
//
//
//#pragma mark -
//#pragma mark Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView             // Default is 1 if not implemented
//{
//    return 2;
//}
//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if(section == 0)
//    {
//        return nil;
//    }else if (section == 1)
//    {
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//
//        
//
//        self.menuScroll = [[menuSrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//        self.menuScroll.contentSize=CGSizeMake(500,40);
//        
//
//        [self.menuScroll setupCategory:@[@"One", @"Two", @"Three",@"four",@"five",@"six"]];
//
//        for (UIView *subview in [self.menuScroll subviews]) {
//            if ([subview isKindOfClass:[UIButton class]]) {
//                UIButton *btn = (UIButton *)subview;
//
//                [btn addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventTouchUpInside];
//
//            }
//        }
//
//        
//        [headerView addSubview:self.menuScroll];
//        
//        return headerView;
//    }else
//        return nil;
//}
//
//-(void)segmentedControlChangedValue:(UIButton *)sender
//{
//    NSLog(@"sender:%lu",sender.tag);
//    [self.menuScroll scrollToPage:(sender.tag - 100)];
//    
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
//        return 1;
//    }else
//    {
//        return self.prodArray.count;
//    }
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        topTableViewCell *topCell =(topTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"topTableViewCell"];
//        if (nil == topCell)
//        {
//            topCell = [[[NSBundle mainBundle]loadNibNamed:@"topTableViewCell" owner:self options:nil] objectAtIndex:0];//加载nib文件
//            topCell.selectionStyle = UITableViewCellSelectionStyleNone;
//            
//            
//            topCell.loopBanner.datasource = self;
//            topCell.loopBanner.delegate = self;
//        }
//        
//        
//        return topCell;
//        
//    }else
//    {
//        productTableViewCell *prodCell =(productTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"productTableViewCell"];
//        if (nil == prodCell)
//        {
//            prodCell = [[[NSBundle mainBundle]loadNibNamed:@"productTableViewCell" owner:self options:nil] objectAtIndex:0];//加载nib文件
//            prodCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        
//        NSString *prodName = [NSString stringWithFormat:@"%@.jpg",self.prodArray[indexPath.row]];
//        [prodCell.productImage setImage:[UIImage imageNamed:prodName]];
//        
//        return prodCell;
//    }
//
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollView.contentOffset.y====:%f",scrollView.contentOffset.y);
//    NSLog(@"_cycleBannerViewTop.frame.size.height+70====:%f",_cycleBannerViewTop.frame.size.height+70);
    NSLog(@"mainscroll====:%@",self.mainScroll);


    if (scrollView.contentOffset.y<_cycleBannerViewTop.frame.size.height+categoryViewHeight-44-44) {
        
    
        
        TestTableViewController *listControllerNow = self.controllerArray[self.pageMenu.currentPageIndex];
        [listControllerNow.tableView setScrollEnabled:NO];
        [self.mainScroll setScrollEnabled:YES];
        self.topBar.alpha = scrollView.contentOffset.y/(_cycleBannerViewTop.frame.size.height+categoryViewHeight-44-44);


        
    }else
    {
        [self.mainScroll setContentOffset:CGPointMake(0, _cycleBannerViewTop.frame.size.height+categoryViewHeight-44-44)];
        
        TestTableViewController *listControllerNow = self.controllerArray[self.pageMenu.currentPageIndex];
        [listControllerNow.tableView setScrollEnabled:YES];
        [self.mainScroll setScrollEnabled:NO];
        self.topBar.alpha = 1.0f;
    }
}


-(void)enableScroll
{
    [self.mainScroll setScrollEnabled:YES];

}

@end
