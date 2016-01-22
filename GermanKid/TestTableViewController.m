//
//  TestTableViewController.m
//  PageMenuDemoStoryboard
//
//  Created by Jin Sasaki on 2015/06/05.
//  Copyright (c) 2015年 Jin Sasaki. All rights reserved.
//

#import "TestTableViewController.h"
#import "productTableViewCell.h"
#import "globalVar.h"

@interface TestTableViewController ()<UIScrollViewDelegate>
@property (nonatomic) NSArray *prodArray;
@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    self.namesArray = @[@"Lauren Richard", @"Nicholas Ray", @"Kim White", @"Charles Gray", @"Timothy Jones", @"Sarah Underwood", @"William Pearl", @"Juan Rodriguez", @"Anna Hunt", @"Marie Turner", @"George Porter", @"Zachary Hecker", @"David Fletcher"];
//    self.photoNameArray= @[@"woman5.jpg", @"man1.jpg", @"woman1.jpg", @"man2.jpg", @"man3.jpg", @"woman2.jpg", @"man4.jpg", @"man5.jpg", @"woman3.jpg", @"woman4.jpg", @"man6.jpg", @"man7.jpg", @"man8.jpg"];
    
    self.prodArray = [[NSMutableArray alloc] initWithObjects:@"prod1",@"prod2",@"prod3",@"prod4",nil];
    
    self.tableView.delaysContentTouches = YES;

    [self.tableView registerNib:[UINib nibWithNibName:@"productTableViewCell" bundle:nil] forCellReuseIdentifier:@"productTableViewCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.prodArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    productTableViewCell *prodCell =(productTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"productTableViewCell"];
    if (nil == prodCell)
    {
        prodCell = [[[NSBundle mainBundle]loadNibNamed:@"productTableViewCell" owner:self options:nil] objectAtIndex:0];//加载nib文件
        prodCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    NSString *prodName = [NSString stringWithFormat:@"%@.jpg",self.prodArray[indexPath.row]];
    
    [prodCell.productImage setImage:[UIImage imageNamed:prodName]];
    [prodCell.prodImage addTarget:self action:@selector(prodTapped:) forControlEvents:UIControlEventTouchUpInside];
    prodCell.prodImage.tag = indexPath.row;
    return prodCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH/2+70;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<= 0) {
        
        [self.tableView setScrollEnabled:NO];
        [self.scrollDelegate enableScroll];
    }
}

-(void)prodTapped:(UIButton *)sender
{
    NSLog(@"product tapped:%lu",sender.tag);
}
@end
