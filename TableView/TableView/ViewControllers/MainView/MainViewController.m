//
//  MainViewController.m
//  TableView
//
//  Created by shadow on 2015/1/6.
//  Copyright (c) 2015年 shadow. All rights reserved.
//

#import "MainViewController.h"
#import "ListCell.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tableViewData;
@synthesize isOpen,selectIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    isOpen = NO;
    
    /****假資料****/
    
    NSArray *array1 = [NSArray arrayWithObjects:@"拉麵",@"壽司",@"炸豬排", nil];
    NSArray *array2 = [NSArray arrayWithObjects:@"牛排",@"炸雞", nil];
    
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:array1,@"日式",array2,@"西式", nil];
    NSDictionary *dictionary = @{@"日式":array1, @"西式":array2};
    [self setContents:dictionary];
    
    /****假資料****/
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getAPIData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSLog(@"param[%@]", params);
    [self getAPIData:@"APIDomain" parameters:params callback:^(id result, NSError *error){
        NSDictionary *dataDictionary = [NSDictionary dictionaryWithDictionary:result];
        NSString *status = [dataDictionary objectForKey:@"status"];
        if ([status isEqualToString:@"success"])
        {
            [self setContents:dataDictionary];
        }
        NSLog(@"id:%@",result);
    }];
}

- (void)setContents:(NSDictionary*)result
{
    if (!tableViewData)
    {
        tableViewData = [[NSMutableArray alloc]init];
        
        for (NSString *key in [result allKeys])
        {
            NSMutableDictionary *row = [[NSMutableDictionary alloc]init];
            [row setValue:key forKey:@"title"];
            
            NSMutableArray *items = [[NSMutableArray alloc]init];
            NSArray *values = [result objectForKey:key];
            for (id subCate in values)
            {
                [items addObject:subCate];
            }
            [row setValue:items forKey:@"list"];
            
            [tableViewData addObject:row];
        }
    }
    [self.tableview reloadData];
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [tableViewData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOpen) {
        if (self.selectIndex.section == section) {
            return [[[tableViewData objectAtIndex:section] objectForKey:@"list"] count] + 1;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
        
        static NSString *CellIdentifier = @"ListCell";
        ListCell *cell = (ListCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        
        NSArray *list = [[tableViewData objectAtIndex:self.selectIndex.section] objectForKey:@"list"];
        cell.titleLabel.text = [list objectAtIndex:(indexPath.row - 1)];
        return cell;
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
            [cell.textLabel setNumberOfLines:3];
        }
        
        NSString *name = [[tableViewData objectAtIndex:indexPath.section] objectForKey:@"title"];
        cell.textLabel.text = name;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //點擊展開列表
    if (indexPath.row == 0) {
        if ([indexPath isEqual:self.selectIndex]) {
            self.isOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            self.selectIndex = nil;
            
        }else
        {
            if (!self.selectIndex) {
                self.selectIndex = indexPath;
                [self didSelectCellRowFirstDo:YES nextDo:NO];
                
            }else
            {
                
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
    }else
    {
        //點擊列表內容要做的事
        NSDictionary *dic = [tableViewData objectAtIndex:indexPath.section];
        NSArray *list = [dic objectForKey:@"list"];
        NSString *item = [list objectAtIndex:indexPath.row-1];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:item message:nil delegate:nil cancelButtonTitle:@"確定" otherButtonTitles: nil];
        [alert show];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    
    [self.tableview beginUpdates];
    int section = (int)self.selectIndex.section;
    int contentCount = (int)[[[tableViewData objectAtIndex:section] objectForKey:@"list"] count];
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    for (NSUInteger i = 1; i < contentCount + 1; i++) {
        NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
        [rowToInsert addObject:indexPathToInsert];
    }
    
    if (firstDoInsert)
    {   [self.tableview insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        [self.tableview deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
    [self.tableview endUpdates];
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = [self.tableview indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen) [self.tableview scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
