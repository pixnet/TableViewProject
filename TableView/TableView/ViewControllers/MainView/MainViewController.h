//
//  MainViewController.h
//  TableView
//
//  Created by shadow on 2015/1/6.
//  Copyright (c) 2015年 shadow. All rights reserved.
//

#import "BaseViewController.h"

@interface MainViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

//是否點擊展開列表
@property (assign)BOOL isOpen;
@property (nonatomic , retain)NSIndexPath *selectIndex;
@property (nonatomic , strong) NSMutableArray *tableViewData;

@property (weak , nonatomic) IBOutlet UITableView *tableview;

@end
