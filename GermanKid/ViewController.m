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
#import "categoryDetailViewController.h"



@interface ViewController ()<KDCycleBannerViewDataSource, KDCycleBannerViewDelegate>

@property (nonatomic, strong) NSMutableArray *prodArray;
@property (nonatomic, strong) NSMutableArray *prodsNow;

@property (nonatomic, strong) NSMutableArray *menuArray;

@property (nonatomic, strong) menuSrollView *menuScroll;
@property (nonatomic, strong) menuSrollView *fakeScroll;


@property (nonatomic,strong) NSMutableArray *controllerArray;
@property (nonatomic,strong) topBarView *topBar;
@property (nonatomic,strong) UIView *headerView;


@end

@implementation ViewController

int menuNow;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self loadCategoryDefault]) {
        self.menuArray = [[NSMutableArray alloc] initWithArray:[self loadCategoryDefault]];
        
    }else
    {
        self.menuArray = [[NSMutableArray alloc] init];
        
    }
    
    if ([self loadProductDefault]) {
        self.prodArray = [[NSMutableArray alloc] initWithArray:[self loadProductDefault]];
        self.prodsNow = [[NSMutableArray alloc] initWithArray:[self sortProducts:self.prodArray ByCategory:self.menuArray[0]]];


    }else
    {
        self.prodArray = [[NSMutableArray alloc] init];

    }


    [self requestAllProduct];

//    NSArray *menuTitles = @[@"menu1",@"menu2",@"menu3",@"menu4",@"menu5",@"menu6",@"menu7",@"menu8"];
//    self.menuArray = menuTitles;
    
    self.navigationController.navigationBarHidden = YES;
    self.topBar = [[topBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.topBar.pagetitle setText:@"德国儿童用品"];
    self.topBar.alpha = 0.0f;
    [self.view addSubview:self.topBar];
    
    menuNow = 0;
    
    [self.mainTableView addObserver: self forKeyPath: @"contentOffset" options: NSKeyValueObservingOptionNew context: nil];
    
    
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (self.mainTableView.contentOffset.y<SCREEN_WIDTH/2+categoryViewHeight-44-44) {
        
        
        
        self.topBar.alpha = self.mainTableView.contentOffset.y/(SCREEN_WIDTH/2+categoryViewHeight-44-44);
        
        [self.fakeScroll setHidden:YES];
        [self.menuScroll setHidden:NO];
        
        
    }else
    {
        [self.fakeScroll setHidden:NO];
        [self.menuScroll setHidden:YES];

        self.topBar.alpha = 1.0f;
    }
    
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

-(NSArray *)loadProductDefault
{
    NSArray *allProduct = [[NSUserDefaults standardUserDefaults] objectForKey:ALL_PRODUCT];
    
    return allProduct;
}
-(NSArray *)loadCategoryDefault
{
    NSArray *allCategory = [[NSUserDefaults standardUserDefaults] objectForKey:ALL_CATEGORY];
    
    return allCategory;
}

-(void)requestAllProduct
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager.requestSerializer setTimeoutInterval:12];  //Time out after 25 seconds
    NSDictionary *parameters = @{@"tag": @"productInfo",@"menu":@"main"};

    
    [manager POST:productURL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"prod Json: %@", responseObject);
        
        NSArray *oneProd = [responseObject objectForKey:@"products"];
        [self.prodArray setArray:oneProd];
        [[NSUserDefaults standardUserDefaults] setObject:self.prodArray forKey:ALL_PRODUCT];
    
        //categories
        NSArray *categories = [responseObject objectForKey:@"categories"];
        [self.menuArray setArray:categories];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.menuArray forKey:ALL_CATEGORY];
        
        [self reloadCategories];
        

        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ups JsonError: %@", error.localizedDescription);
        NSLog(@"ups Json ERROR: %@",  operation.responseObject);
        
        
    }];
    

}



-(NSMutableArray *)sortProducts:(NSArray *)array ByCategory:(NSString *)key
{
    NSMutableArray *productsNow = [[NSMutableArray alloc] init];
    
    if (array && key) {
        for (NSDictionary *oneProd in array) {
            if ([[oneProd objectForKey:@"category"] isEqualToString:key]) {
                [productsNow addObject:oneProd];
            }
        }
    }
    
    return productsNow;
}

-(void)categoryTap:(UIButton *)sender
{
    categoryDetailViewController *categoryDetailVC = [[categoryDetailViewController alloc] initWithNibName:@"categoryDetailViewController" bundle:nil];
    [self.navigationController pushViewController:categoryDetailVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
#pragma mark - KDCycleBannerViewDataSource

- (NSArray *)numberOfKDCycleBannerView:(KDCycleBannerView *)bannerView {
    NSArray *allBanner = [[NSUserDefaults standardUserDefaults] objectForKey:ALL_BANNER];
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i = 0; i<allBanner.count; i++) {
        NSString * bannerImage = [NSString stringWithFormat:@"http://cgx.nwpu.info/GermanKid/banners/%@.jpg",[allBanner[i] objectForKey:@"product_name"]];
        NSURL *url = [NSURL URLWithString: [bannerImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [imageArray insertObject:url atIndex:[[allBanner[i] objectForKey:@"banner_index"] integerValue]];
    }
    NSArray *banners = [[NSArray alloc] initWithArray:imageArray];
    return banners;
    

}

- (UIViewContentMode)contentModeForImageIndex:(NSUInteger)index {
    return UIViewContentModeScaleAspectFill;
}


- (UIImage *)placeHolderImageOfBannerView:(KDCycleBannerView *)bannerView atIndex:(NSUInteger)index;
{

    return [UIImage imageNamed:@"networkError.png"];

}


#pragma mark - KDCycleBannerViewDelegate

- (void)cycleBannerView:(KDCycleBannerView *)bannerView didScrollToIndex:(NSUInteger)index {
//    NSLog(@"didScrollToIndex~~~~~~~~~~:%ld", (long)index);
}

- (void)cycleBannerView:(KDCycleBannerView *)bannerView didSelectedAtIndex:(NSUInteger)index {
    NSLog(@"didSelectedAtIndex:%ld", (long)index);
    NSArray *allBanner = [[NSUserDefaults standardUserDefaults] objectForKey:ALL_BANNER];

    NSString *productName = [allBanner[index] objectForKey:@"product_name"];
    detailViewController *detailView = [[detailViewController alloc] initWithNibName:@"detailViewController" bundle:nil];
    detailView.isFromBanner = YES;
    detailView.name = productName;
    
    
    [self.navigationController pushViewController:detailView  animated:YES];
    
    
}



#pragma mark -
#pragma mark Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    if (indexPath.section ==0) {
    return SCREEN_WIDTH/2+categoryViewHeight;
}else
    {
        return SCREEN_WIDTH/2+56;
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

-(void)reloadCategories
{
    menuNow = 0;
    
    for (UIView *subview in [self.menuScroll subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subview;
            [btn removeFromSuperview];
            
        }
    }
    
    [self.menuScroll setupCategory:self.menuArray];
    for (UIView *subview in [self.menuScroll subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subview;
            
            [btn addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    
    [self.menuScroll scrollToPage:menuNow];
    
    
    for (UIView *subview in [self.fakeScroll subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subview;
            [btn removeFromSuperview];
            
        }
    }
    
    [self.fakeScroll setupCategory:self.menuArray];
    for (UIView *subview in [self.fakeScroll subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subview;
            
            [btn addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    
    [self.fakeScroll scrollToPage:menuNow];
    
    self.prodsNow = [[NSMutableArray alloc] initWithArray:[self sortProducts:self.prodArray ByCategory:self.menuArray[0]]];

    
    NSIndexSet *indexSet1 = [[NSIndexSet alloc] initWithIndex: 1];
    [self.mainTableView reloadSections:indexSet1 withRowAnimation:UITableViewRowAnimationFade];
    
}

-(void)segmentedControlChangedValue:(UIButton *)sender
{
    NSLog(@"sender:%lu",sender.tag);
    menuNow =sender.tag - 100;
    [self.menuScroll scrollToPage:(sender.tag - 100)];
    [self.fakeScroll scrollToPage:(sender.tag - 100)];
    
    self.prodsNow = [[NSMutableArray alloc] initWithArray:[self sortProducts:self.prodArray ByCategory:self.menuArray[menuNow]]];

    
    NSRange range = NSMakeRange(1, [self numberOfSectionsInTableView:self.mainTableView]-1);
    NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.mainTableView reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];

    if (self.mainTableView.contentOffset.y >= (SCREEN_WIDTH/2+categoryViewHeight-44-40)) {
        [self.mainTableView setContentOffset:CGPointMake(0, SCREEN_WIDTH/2+categoryViewHeight-44-40)];

    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else
    {
        return self.prodsNow.count%2 == 0?self.prodsNow.count/2:self.prodsNow.count/2+1;
        
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
        
        
        NSDictionary *firstProduct = self.prodsNow[2*indexPath.row];
        if (2*indexPath.row+1<self.prodsNow.count) {
            NSDictionary *secondProduct = self.prodsNow[2*indexPath.row+1];
            NSString *prodNameTwo = [secondProduct objectForKey:@"name"];
            NSString *prodTwoLike = [secondProduct objectForKey:@"like_count"];
            
            [prodCell.prodTwoLikeNumber setText:prodTwoLike];
            [prodCell.prodNameTwo setText:prodNameTwo];

            [prodCell.productImageTwo setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",prodNameTwo]]];
            [prodCell.prodButtonTwo addTarget:self action:@selector(prodTapped:) forControlEvents:UIControlEventTouchUpInside];
            prodCell.prodButtonTwo.tag = indexPath.row*2+1;
            [prodCell.productImageTwo.superview setHidden:NO];


        }else
        {
            [prodCell.productImageTwo.superview setHidden:YES];
        }

        NSString *prodNameOne = [firstProduct objectForKey:@"name"];
        NSString *prodOneLike = [firstProduct objectForKey:@"like_count"];
        
        [prodCell.prodOneLikeNumber setText:prodOneLike];
        [prodCell.prodNameOne setText:prodNameOne];
        [prodCell.productImageOne setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",prodNameOne]]];
        [prodCell.prodButtonOne addTarget:self action:@selector(prodTapped:) forControlEvents:UIControlEventTouchUpInside];
        prodCell.prodButtonOne.tag = indexPath.row*2;
        
       
        
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
-(void)prodTapped:(UIButton *)sender
{
    
    NSLog(@"product tapped:%lu",sender.tag);
    
    detailViewController *detailView = [[detailViewController alloc] initWithNibName:@"detailViewController" bundle:nil];
    detailView.isFromBanner = NO;

    detailView.name = [self.prodsNow[sender.tag] objectForKey:@"name"];
    detailView.likeCount = [self.prodsNow[sender.tag] objectForKey:@"like_count"];
    detailView.price = [self.prodsNow[sender.tag] objectForKey:@"price"];
    detailView.discount = [self.prodsNow[sender.tag] objectForKey:@"discount"];
    detailView.productUrl = [self.prodsNow[sender.tag] objectForKey:@"url"];
    detailView.imageCount = [self.prodsNow[sender.tag] objectForKey:@"image_count"];
    detailView.introduct = [self.prodsNow[sender.tag] objectForKey:@"introduct"];

    
    [self.navigationController pushViewController:detailView  animated:YES];
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
            self.prodsNow = [[NSMutableArray alloc] initWithArray:[self sortProducts:self.prodArray ByCategory:self.menuArray[menuNow]]];

            [self.mainTableView reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
            if (self.mainTableView.contentOffset.y >= (SCREEN_WIDTH/2+categoryViewHeight-44-40)) {
                [self.mainTableView setContentOffset:CGPointMake(0, SCREEN_WIDTH/2+categoryViewHeight-44-40)];
                
            }
            
        }
        
        
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        if (menuNow>0) {
            [self.menuScroll scrollToPage:(menuNow -1)];
            [self.fakeScroll scrollToPage:(menuNow- 1)];
            menuNow--;
            self.prodsNow = [[NSMutableArray alloc] initWithArray:[self sortProducts:self.prodArray ByCategory:self.menuArray[menuNow]]];

            [self.mainTableView reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
            if (self.mainTableView.contentOffset.y >= (SCREEN_WIDTH/2+categoryViewHeight-44-40)) {
                [self.mainTableView setContentOffset:CGPointMake(0, SCREEN_WIDTH/2+categoryViewHeight-44-40)];
                
            }
        }
        
    }
    
}
-(void)dealloc
{
    [self.mainTableView removeObserver:self forKeyPath:@"contentOffset"];
}
@end
