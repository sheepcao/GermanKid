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
#import "detailTableViewCell.h"
#import "detailFirstTableViewCell.h"
#import "taobaoViewController.h"

#define StretchHeaderHeight 300
#define BuyBarHeight 50

@interface detailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *mineTable;
@property (nonatomic,strong) HFStretchableTableHeaderView *stretchHeaderView;
@property (nonatomic,strong) topBarView *topBar;
//@property (nonatomic, strong) NSMutableArray *prodArray;
@property (nonatomic, strong) NSMutableArray *prodDescriptionArray;

@property (nonatomic, strong) UIView *BuyBar;


//@property (nonatomic, strong) detailTableViewCell *detaiCell;
@end

@implementation detailViewController

- (UITableView *)mineTable
{
    if (_mineTable == nil) {
        _mineTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width+2, [UIScreen mainScreen].bounds.size.height-BuyBarHeight) style:UITableViewStylePlain];
        _mineTable.delegate = self;
        _mineTable.dataSource = self;
        _mineTable.showsVerticalScrollIndicator = NO;
        _mineTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _mineTable.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        _mineTable.backgroundColor = [UIColor whiteColor];
        
        
        [self.view addSubview:_mineTable];
    }
    return _mineTable;
}

- (UIView *)attachBuyBar
{
    if (_BuyBar == nil) {
        _BuyBar = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, BuyBarHeight)];
        
        _BuyBar.backgroundColor = [UIColor whiteColor];
        
        UIButton *buyButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -135, 8, 110, 34)];
        [buyButton setTitle:@"购买" forState:UIControlStateNormal];
        buyButton.backgroundColor = [UIColor colorWithRed:255/255.0f green:58/255.0f blue:61/255.0f alpha:1.0f];
        buyButton.layer.cornerRadius = 17.0f;
        buyButton.layer.shadowOffset = CGSizeMake(0.5, 0.8);
        buyButton.layer.shadowRadius = 0.5;
        buyButton.layer.shadowOpacity = 0.4;
        [buyButton addTarget:self action:@selector(toTaobao) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *priceTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 30)];
        priceTitle.text = @"我想买,求特价";
        priceTitle.font = [UIFont systemFontOfSize:15.5f weight:UIFontWeightLight];
        
        UIButton *wantButton = [[UIButton alloc] initWithFrame:CGRectMake(priceTitle.frame.origin.x+priceTitle.frame.size.width, 14, 22, 22)];
        [wantButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [wantButton addTarget:self action:@selector(iWantThis:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_BuyBar addSubview:priceTitle];
        [_BuyBar addSubview:wantButton];
        [_BuyBar addSubview:buyButton];
        
        
        [self.view addSubview:_BuyBar];
    }
    return _BuyBar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (self.isFromBanner) {
        [self requestAllProductInfo];
        
    }else
    {
        [self requestDetailInfo];
    }
    self.topBar = [[topBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.topBar.pagetitle setText:@"细嗅精华"];
    self.topBar.alpha = 0.0f;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 28, 40, 30)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backTap) forControlEvents:UIControlEventTouchUpInside];
    [self.topBar addSubview:backBtn];
    
    [self mineTable];
    [self attachBuyBar];
    
    
    
    [self initStretchHeader];
    
    [self.view addSubview:self.topBar];
    
    [self.mineTable addObserver: self forKeyPath: @"contentOffset" options: NSKeyValueObservingOptionNew context: nil];
    
    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (self.mineTable.contentOffset.y<(SCREEN_HEIGHT/2))
    {
        
        self.topBar.alpha = self.mineTable.contentOffset.y/(SCREEN_HEIGHT/2);
        
    }else
    {
        self.topBar.alpha = 1.0f;
    }
    
}
-(void)backTap
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)requestAllProductInfo
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager.requestSerializer setTimeoutInterval:12];  //Time out after 25 seconds
    NSDictionary *parameters = @{@"tag": @"entireProductInfo",@"productName":self.name};
    
    
    [manager POST:entireProductURL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"entire Json: %@", responseObject);
        
        NSArray *details = [responseObject objectForKey:@"details"];
        self.prodDescriptionArray = [[NSMutableArray alloc] initWithCapacity:details.count];
        
        for (int i =0; i<details.count; i++) {
            
            for (int j =0 ; j<details.count; j++) {
                if ([[details[j] objectForKey:@"introduct_index"] integerValue] == i) {
                    [self.prodDescriptionArray insertObject:[details[j] objectForKey:@"content"] atIndex:i];
                    break;
                }
            }
        }
        self.introduct = [responseObject objectForKey:@"introduct"];
        self.price = [responseObject objectForKey:@"price"];
        self.discount = [responseObject objectForKey:@"discount"];
        self.imageCount = [responseObject objectForKey:@"image_count"];
        self.likeCount = [responseObject objectForKey:@"like_count"];
        self.productUrl = [responseObject objectForKey:@"url"];
        
        [self.mineTable reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ups JsonError: %@", error.localizedDescription);
        NSLog(@"ups Json ERROR: %@",  operation.responseObject);
        
        
    }];
    
}
-(void)requestDetailInfo
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager.requestSerializer setTimeoutInterval:12];  //Time out after 25 seconds
    NSDictionary *parameters = @{@"tag": @"detailInfo",@"productName":self.name};
    
    
    [manager POST:detailURL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"details Json: %@", responseObject);
        
        NSArray *banners = [responseObject objectForKey:@"details"];
        self.prodDescriptionArray = [[NSMutableArray alloc] initWithCapacity:banners.count];
        
        for (int i =0; i<banners.count; i++) {
            
            for (int j =0 ; j<banners.count; j++) {
                if ([[banners[j] objectForKey:@"introduct_index"] integerValue] == i) {
                    [self.prodDescriptionArray insertObject:[banners[j] objectForKey:@"content"] atIndex:i];
                    break;
                }
            }
        }
        [self.mineTable reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ups JsonError: %@", error.localizedDescription);
        NSLog(@"ups Json ERROR: %@",  operation.responseObject);
        
        
    }];
    
    
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
    
    
    
    self.stretchHeaderView = [HFStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self.mineTable withView:bgImageView subViews:contentView];
    
}

-(void)iWantThis:(UIButton *)sender
{
    
    [sender setFrame:CGRectMake(sender.frame.origin.x, sender.frame.origin.y - 3, sender.frame.size.width+6, sender.frame.size.height+6)];
    [sender setImage:[UIImage imageNamed:@"liked2.png"] forState:UIControlStateDisabled];
    sender.enabled = NO;
    
    
}

-(void)toTaobao
{
    taobaoViewController *taobao = [[taobaoViewController alloc] initWithNibName:@"taobaoViewController" bundle:nil];
    taobao.taobaoURL = self.productUrl;
    [self presentViewController:taobao animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table delegate

-(detailTableViewCell *)holdDetailCell
{
    detailTableViewCell *detailCell = [[[NSBundle mainBundle]loadNibNamed:@"detailTableViewCell" owner:self options:nil] objectAtIndex:0];//加载nib文件
    
    return detailCell;
    
    
}
-(CGFloat)heightForText:(NSString *)str width:(int)width font:(UIFont *)font lineBreakMode:(NSLineBreakMode) lineBreakMode
{
    CGSize textSize;
    textSize = [str boundingRectWithSize:CGSizeMake(width, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    return textSize.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150;
        
    }else
    {
        NSString *str = self.prodDescriptionArray[indexPath.row-1];
        
        CGFloat labelHeight = [self heightForText:str width:320 font:[UIFont fontWithName:@"HelveticaNeue" size:15.0]lineBreakMode:NSLineBreakByWordWrapping];
        
        
        //        NSLog(@"height for %d  --is :%f",indexPath.row-1,labelHeight+SCREEN_WIDTH-80+70);
        
        return labelHeight+SCREEN_WIDTH-80+40;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.imageCount integerValue]+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    
    if (indexPath.row == 0) {
        
        detailFirstTableViewCell *detailFirst =(detailFirstTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"detailFirst"];
        if (nil == detailFirst)
        {
            detailFirst = [[[NSBundle mainBundle]loadNibNamed:@"detailFirstTableViewCell" owner:self options:nil] objectAtIndex:0];//加载nib文件
            detailFirst.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        [detailFirst.prodName setText:self.name];
        if ([self.discount isEqualToString:@"no"]) {
            [detailFirst.priceNow setText:[NSString stringWithFormat:@"¥:%@",self.price]];
            [detailFirst.originalPrice setHidden:YES];
        }else
        {
            [detailFirst.priceNow setText:[NSString stringWithFormat:@"¥:%@",self.discount]];
            [detailFirst.originalPrice setHidden:NO];
            [detailFirst.originalPrice setText:[NSString stringWithFormat:@"价格:%@",self.price]];
            
        }
        
        [detailFirst.prodDescrip setText:self.introduct];
        
        
        
        cell = detailFirst;
        
    }else
    {
        detailTableViewCell *detailCell =(detailTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
        if (nil == detailCell)
        {
            detailCell = [[[NSBundle mainBundle]loadNibNamed:@"detailTableViewCell" owner:self options:nil] objectAtIndex:0];//加载nib文件
            detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        NSString *imageURL = [NSString stringWithFormat:@"%@/%@/%lu.jpg",BaseURL,self.name,indexPath.row-1];
        NSURL *destURL = [NSURL URLWithString: [imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        [detailCell.imageDetail setImageWithURL:destURL placeholderImage:[UIImage imageNamed:@"networkError.png"]];
        
        
        if ([self.prodDescriptionArray[indexPath.row-1] isEqualToString:@"no"]) {
            [detailCell.descrip setText:@""];
        }else
        {
            [detailCell.descrip setText:self.prodDescriptionArray[indexPath.row-1]];
        }
        NSLog(@"descrip:%@----%lu",detailCell.descrip,indexPath.row-1);
        
        [detailCell setNeedsDisplay];
        
        cell = detailCell;
        
    }
    
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
}


- (void)viewDidLayoutSubviews
{
    [self.stretchHeaderView resizeView];
}

-(void)dealloc
{
    [self.mineTable removeObserver:self forKeyPath:@"contentOffset"];
}

@end
