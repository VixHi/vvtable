//
//  ViewController.m
//  vvtable
//
//  Created by Vix Liu on 2020/4/22.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property(nonatomic, strong) VTableViewDataSource *datasource;
@property(nonatomic, strong) VBaseTableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ViewController

- (VTableViewDataSource *)datasource {
    if (!_datasource) {
        _datasource = [VTableViewDataSource new];
    }
    return _datasource;
}

- (VBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[VBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(90);
            make.left.offset(0);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    return _tableView;
}


- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self methodM];
    [self getData];

}

- (void) setupUI {
    [self.datasource registerTableView:self.tableView cellIdentifier:@"VTestCell"];
    [self.datasource registerTable:self.tableView sectionHeaderIdentifier:@"VSectionHeadView"];
    [self.datasource registerTable:self.tableView sectionFooterIdentifier:@"VSectionFooterView"];
}

- (void)methodM {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_footer resetNoMoreData];
        [self.dataArr removeAllObjects];
        [self getData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getData];
    }];
    
    self.datasource.clickCellBlock = ^(id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"第%ld个分区，第%ld行  对应的model是 %@", indexPath.section, indexPath.row, model);
    };

}

- (void) getData {
    
    NSArray *tempArr = @[@"李白", @"杜甫", @"白居易", @"王维", @"孟浩然", @"张九龄", @"韩愈", @"柳宗元", @"苏轼", @"苏洵", @"苏辙", @"王安石", @"欧阳修", @"曾巩"];
    int index = arc4random() % tempArr.count;
    VBaseModel *model = [VBaseModel new];
    if (index > tempArr.count - 1) {
        return;
    }
    model.cellText = tempArr[index];
    
/****
★ ☆ ★
多个分区需要对model.sectionArr 进行赋值处理，单个分区不需要处理
对分区的点击处理需要去自定义的分区处理
!**/

    
    NSMutableArray *tempModelArr = @[model, model, model];
    model.rows = tempModelArr;
    
    
    [self.dataArr addObject:model];
    
    [self.datasource cellForData:^id _Nonnull{
        return self.dataArr;
    } completion:^{
        [self.tableView reloadData];
        [self endRefersh];
    }];

}

- (void) endRefersh {
    if(self.tableView.mj_header.isRefreshing){
        [self.tableView.mj_header endRefreshing];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
}



    



@end
