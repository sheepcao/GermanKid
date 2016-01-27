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
#define StretchHeaderHeight 200

@interface detailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *mineTable;
@property (nonatomic,strong) HFStretchableTableHeaderView *stretchHeaderView;
@property (nonatomic,strong) topBarView *topBar;
@property (nonatomic, strong) NSMutableArray *prodArray;
@property (nonatomic, strong) NSMutableArray *prodDescriptionArray;

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
        
        [self.view addSubview:_mineTable];
    }
    return _mineTable;
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
    

    
    self.stretchHeaderView = [HFStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self.mineTable withView:bgImageView subViews:contentView];
    
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
    NSString *str = self.prodDescriptionArray[indexPath.row];
    

    
//    UIImageView *image = [self holdDetailCell].imageDetail;
    
    CGFloat labelHeight = [self heightForText:str width:320 font:[UIFont fontWithName:@"HelveticaNeue" size:15.0]lineBreakMode:NSLineBreakByWordWrapping];


    NSLog(@"height for %d  --is :%f",indexPath.row,labelHeight+SCREEN_WIDTH-80+70);
    
    return labelHeight+SCREEN_WIDTH-80+40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.prodArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailTableViewCell *detailCell =(detailTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    if (nil == detailCell)
    {
        detailCell = [[[NSBundle mainBundle]loadNibNamed:@"detailTableViewCell" owner:self options:nil] objectAtIndex:0];//加载nib文件
        detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSLog(@"&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
        
    }
    
    NSString *prodName = [NSString stringWithFormat:@"%@.jpg",self.prodArray[indexPath.row]];

    [detailCell.imageDetail setImage:[UIImage imageNamed:prodName]];
    


    [detailCell.descrip setText:self.prodDescriptionArray[indexPath.row]];

    NSLog(@"descrip:%@----%d",detailCell.descrip,indexPath.row);
    
    [detailCell setNeedsDisplay];

    
  
    return detailCell;
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
