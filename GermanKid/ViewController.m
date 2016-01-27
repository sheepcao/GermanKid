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
#import "topBarView.h"
#import "categoryView.h"
#import "detailViewController.h"
#import "taobaoViewController.h"



@interface ViewController ()<KDCycleBannerViewDataSource, KDCycleBannerViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *prodArray;
@property (nonatomic, strong) NSArray *menuArray;

@property (nonatomic, strong) menuSrollView *menuScroll;
@property (nonatomic, strong) menuSrollView *fakeScroll;


@property (strong, nonatomic) KDCycleBannerView *cycleBannerViewTop;
@property (nonatomic,strong) NSMutableArray *controllerArray;
@property (nonatomic,strong) topBarView *topBar;
@property (nonatomic,strong) UIView *headerView;
@end

@implementation ViewController

int menuNow;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.prodArray = [[NSMutableArray alloc] initWithObjects:@"prod1",@"prod2",@"prod3",@"prod4",nil];
    
    NSArray *menuTitles = @[@"menu1",@"menu2",@"menu3",@"menu4",@"menu5",@"menu6",@"menu7",@"menu8"];
    self.menuArray = menuTitles;

    self.navigationController.navigationBarHidden = YES;
    self.topBar = [[topBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.topBar.pagetitle setText:@"德国儿童用品"];
    self.topBar.alpha = 0.0f;
    [self.view addSubview:self.topBar];
    
    menuNow = 0;


    

}

-(void)viewDidLayoutSubviews
{
    
    if (SCREEN_MAX_LENGTH>700) {
        
        [self.LeftDistance setConstant:-20];
        [self.rightDistance setConstant:-20];
        [self.mainTableView setNeedsUpdateConstraints];
        

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

//
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



#pragma mark -
#pragma mark Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    if (indexPath.section ==0) {
    return SCREEN_WIDTH/2+categoryViewHeight;
}else
{
    return SCREEN_WIDTH/2+70;
}
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else
    {
        return 40;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}




#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView             // Default is 1 if not implemented
{
    return 2;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return nil;
    }else if (section == 1)
    {
       
        

        if (!self.headerView) {
            self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];

            self.menuScroll = [[menuSrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            self.menuScroll.contentSize=CGSizeMake(700,40);
            
            
            [self.menuScroll setupCategory:self.menuArray];
            
            
            for (UIView *subview in [self.menuScroll subviews]) {
                if ([subview isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)subview;
                    
                    [btn addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
            }
            
            [self.headerView addSubview:self.menuScroll];
            [self.menuScroll scrollToPage:menuNow];

            
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
    

        
        
        return self.headerView;
    }else
        return nil;
}

-(void)segmentedControlChangedValue:(UIButton *)sender
{
    NSLog(@"sender:%lu",sender.tag);
    menuNow =sender.tag - 100;
    [self.menuScroll scrollToPage:(sender.tag - 100)];
    [self.fakeScroll scrollToPage:(sender.tag - 100)];
    NSRange range = NSMakeRange(1, [self numberOfSectionsInTableView:self.mainTableView]-1);
    NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.mainTableView reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else
    {
        return self.prodArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        topTableViewCell *topCell =(topTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"topTableViewCell"];
        if (nil == topCell)
        {
            topCell = [[[NSBundle mainBundle]loadNibNamed:@"topTableViewCell" owner:self options:nil] objectAtIndex:0];//加载nib文件
            topCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            topCell.loopBanner.datasource = self;
            topCell.loopBanner.delegate = self;
            
            categoryView *cateView = [[categoryView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, categoryViewHeight)];
            [topCell.bottomView addSubview:cateView];
            
            [cateView.firstBtn addTarget:self action:@selector(categoryTap:) forControlEvents:UIControlEventTouchUpInside];
            [cateView.secondBtn addTarget:self action:@selector(categoryTap:) forControlEvents:UIControlEventTouchUpInside];
            [cateView.thirdBtn addTarget:self action:@selector(categoryTap:) forControlEvents:UIControlEventTouchUpInside];
            [cateView.forthBtn addTarget:self action:@selector(categoryTap:) forControlEvents:UIControlEventTouchUpInside];


            
        }
        
        
        return topCell;
        
    }else
    {
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
        

        
        NSString *prodName = [NSString stringWithFormat:@"%@.jpg",self.prodArray[indexPath.row]];
        
        [prodCell.productImageOne setImage:[UIImage imageNamed:prodName]];
        [prodCell.prodButtonOne addTarget:self action:@selector(prodTapped:) forControlEvents:UIControlEventTouchUpInside];
        prodCell.prodButtonOne.tag = indexPath.row*2;
        
        [prodCell.productImageTwo setImage:[UIImage imageNamed:prodName]];
        [prodCell.prodButtonTwo addTarget:self action:@selector(prodTapped:) forControlEvents:UIControlEventTouchUpInside];
        prodCell.prodButtonTwo.tag = indexPath.row*2+1;
        
        return prodCell;
    }

}
-(void)prodTapped:(UIButton *)sender
{
    
    NSLog(@"product tapped:%lu",sender.tag);
    
    taobaoViewController *taobaoView = [[taobaoViewController alloc] initWithNibName:@"taobaoViewController" bundle:nil];
    [self.view.window.rootViewController presentViewController:taobaoView animated:YES completion:nil];
    
    //    [self.navigationController pushViewController:taobaoView animated:YES];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
//    [self.mainTableView reloadData];
    NSRange range = NSMakeRange(1, [self numberOfSectionsInTableView:self.mainTableView]-1);
    NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];

    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (menuNow<self.menuArray.count-1) {
            [self.menuScroll scrollToPage:(menuNow +1)];
            [self.fakeScroll scrollToPage:(menuNow +1)];
            menuNow++;
            [self.mainTableView reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];


        }
        

    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
       
        if (menuNow>0) {
            [self.menuScroll scrollToPage:(menuNow -1)];
            [self.fakeScroll scrollToPage:(menuNow- 1)];
            menuNow--;
            [self.mainTableView reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];

        }
        
    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{


    if (scrollView.contentOffset.y<SCREEN_WIDTH/2+categoryViewHeight-44-40) {
        
    
        
              self.topBar.alpha = scrollView.contentOffset.y/(SCREEN_WIDTH/2+categoryViewHeight-44-40);

        [self.fakeScroll setHidden:YES];

        
    }else
    {
        [self.fakeScroll setHidden:NO];
               self.topBar.alpha = 1.0f;
    }
}

//
//-(void)enableScroll
//{
//    [self.mainScroll setScrollEnabled:YES];
//
//}

@end
