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

@interface detailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *mineTable;
@property (nonatomic,strong) HFStretchableTableHeaderView *stretchHeaderView;
@property (nonatomic,strong) topBarView *topBar;
@property (nonatomic, strong) NSMutableArray *prodArray;
@property (nonatomic, strong) NSMutableArray *prodDescriptionArray;

@property (nonatomic, strong) UIView *BuyBar;


//@property (nonatomic, strong) detailTableViewCell *detaiCell;
@end

@implementation detailViewController

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

- (UIView *)attachBuyBar
{
    if (_BuyBar == nil) {
        _BuyBar = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        
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
        priceTitle.font = [UIFont systemFontOfSize:14.5f];

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
    self.prodArray = [[NSMutableArray alloc] initWithObjects:@"prod1",@"prod2",@"prod3",@"prod4",nil];
    self.prodDescriptionArray = [[NSMutableArray alloc] initWithObjects:@"你参赛队",@"麻将是 v 南京东方女篮扩大双方就能看到你吧；凌晨 v 可惜你离开就是你德拉克马；上课吗",@"参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队你参赛队",@"啊实打实的出现33333333333333333333333333",nil];
    
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
        
        
        NSLog(@"height for %d  --is :%f",indexPath.row-1,labelHeight+SCREEN_WIDTH-80+70);
        
        return labelHeight+SCREEN_WIDTH-80+40;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.prodArray.count+1;
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
        cell = detailFirst;

    }else
    {
        detailTableViewCell *detailCell =(detailTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
        if (nil == detailCell)
        {
            detailCell = [[[NSBundle mainBundle]loadNibNamed:@"detailTableViewCell" owner:self options:nil] objectAtIndex:0];//加载nib文件
            detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        NSString *prodName = [NSString stringWithFormat:@"%@.jpg",self.prodArray[indexPath.row-1]];
        
        [detailCell.imageDetail setImage:[UIImage imageNamed:prodName]];
        
        
        
        [detailCell.descrip setText:self.prodDescriptionArray[indexPath.row-1]];
        
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
