//
//  HomePageViewController.m
//  BusForWork
//
//  Created by 周传森 on 2019/8/10.
//  Copyright © 2019 森. All rights reserved.
//

#import "HomePageViewController.h"
#import "ZSHomePageLogic.h"
#import "ZSHomePageCell.h"
#import "ZSHomePageUIModel.h"
@interface HomePageViewController ()<ZSHomePageLogicDelegate>
@property (nonatomic, strong) ZSHomePageLogic * logic;
@property (nonatomic, strong) UIActivityIndicatorView * indeicator;
@end


static NSString * ZSHomePageCellID = @"ZSHomePageCellID";
@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadIndicator];

    
    self.logic = [[ZSHomePageLogic alloc] init];
    self.logic.delegate = self;
    [self.indeicator startAnimating];
    [self.logic loadDatas];
    
    
    [self.tableView registerClass:[ZSHomePageCell class] forCellReuseIdentifier:ZSHomePageCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = item;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadIndicator
{
    self.indeicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:self.indeicator];
    self.indeicator.frame = CGRectMake((SCREEN_WIDTH - 100)/2, 100, 100, 100);
    self.indeicator.color = [UIColor orangeColor];
    self.indeicator.backgroundColor = [UIColor clearColor];
    self.indeicator.hidesWhenStopped = YES;
}

- (void)refresh
{
    [self.indeicator startAnimating];
    self.view.userInteractionEnabled = NO;
    [self.logic loadDatas];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _logic.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZSHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:ZSHomePageCellID forIndexPath:indexPath];
    
    ZSHomePageUIModel * model = _logic.dataArr[indexPath.row];
    [cell resetUI:model];
    
    return cell;
}

#pragma mark ZSHomePageLogicDelegate
- (void)didLoadData
{
    [self.indeicator stopAnimating];
    self.view.userInteractionEnabled = YES;
    [self.tableView reloadData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
