//
//  VTableViewDataSource.m
//  VVTableView
//
//  Created by Vix Liu on 2020/4/22.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import "VTableViewDataSource.h"
#import "VBaseModel.h"
#import "VBaseTableView.h"
#import "UITableViewCell+vv.h"


@interface VTableViewDataSource () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, strong) NSArray *dataSouce;

@end

@implementation VTableViewDataSource

- (NSArray *)dataSouce {
    if (!_dataSouce) {
        _dataSouce = [NSArray array];
    }
    return _dataSouce;
}

#pragma mark ------^_^ 私有方法 ^_^--------
- (id)itemAtIndexPath:(NSIndexPath *) indexPath {
    return self.dataSouce[indexPath.row];
}

- (void) configure :(VBaseTableView *) tableView identifier:(NSString *) cellIdentifier {
    
    tableView.delegate = self;
    tableView.dataSource = self;
    self.cellIdentifier = cellIdentifier;
    [UITableViewCell registerTableView:tableView indentifier:cellIdentifier];
}

- (void) configure :(VBaseTableView *) tableView identifier:(NSString *) cellIdentifier xib:(NSString *) xibName {
    
    tableView.delegate = self;
    tableView.dataSource = self;
    self.cellIdentifier = cellIdentifier;
    [tableView registerNib:[UINib nibWithNibName:xibName bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [UITableViewCell registerTableView:tableView xibIndentifier:xibName];

}

- (void) getDataSource: (NSArray *(^)(void)) modelArray completion: (void (^)(void)) completion {
    if (modelArray) {
        self.dataSouce = modelArray();
        if (completion) {
            completion();
        }
    }
}


#pragma mark ------^_^ tableViewDelegate ^_^--------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id item = [self itemAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    [cell configure:cell model:item indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VBaseModel *model = [self itemAtIndexPath:indexPath];
    if ([model isKindOfClass:[VBaseModel class]]) {
        if (model.cellHeight) {
            return model.cellHeight;
        } else {
            tableView.estimatedRowHeight = 88;
            return UITableViewAutomaticDimension;
        }
    }else {
        tableView.estimatedRowHeight = 88;
        return UITableViewAutomaticDimension;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VBaseModel *model = [self itemAtIndexPath:indexPath];
    if (self.selectCellBlock) {
        self.selectCellBlock(model, indexPath);
    }
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return _isCellSideSlip;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_editStrs == nil) {
        _editStrs = @[@"删除"];
    }
    NSMutableArray  *operationArr = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    for (NSString *str in _editStrs) {
        UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:str handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            weakSelf.editCellBlock(weakSelf.dataSouce[indexPath.row], indexPath, str);
        }];
        [operationArr addObject:rowAction];
    }
    return operationArr;
}


@end
