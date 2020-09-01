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
#import "UITableViewHeaderFooterView+vv.h"

@interface VTableViewDataSource () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) NSString *sectionHeaderIdentifier;
@property (nonatomic, copy) NSString *sectionFooterIdentifier;
@property (nonatomic, strong) VBaseModel *targetModel;
@property (nonatomic, strong) NSArray <VBaseModel*> *dataSouce;

@end

@implementation VTableViewDataSource


- (NSArray<VBaseModel *> *)dataSouce {
    if (!_dataSouce) {
        _dataSouce = [NSArray array];
    }
    return _dataSouce;
}

#pragma mark ------^_^ 私有方法 ^_^--------
- (id)itemAtIndexPath:(NSIndexPath *) indexPath {
    self.targetModel = self.dataSouce[indexPath.section];
    return self.targetModel.rows[indexPath.row];
}

- (void) registerTableView :(VBaseTableView *) tableView cellIdentifier:(NSString *) identifier {
    
    tableView.delegate = self;
    tableView.dataSource = self;
    self.cellIdentifier = identifier;
    [UITableViewCell registerTableView:tableView indentifier:identifier];
}

- (void) registerTableView:(VBaseTableView *) tableView cellIdentifier:(NSString *) identifier xib:(NSString *) xibName {
    
    tableView.delegate = self;
    tableView.dataSource = self;
    self.cellIdentifier = identifier;
    [tableView registerNib:[UINib nibWithNibName:xibName bundle:nil] forCellReuseIdentifier:identifier];
    [UITableViewCell registerTableView:tableView xibIndentifier:xibName];

}


- (void) registerTable:(VBaseTableView *) tableView sectionHeaderIdentifier:(NSString *) identifier {
    self.sectionHeaderIdentifier = identifier;
    [UITableViewHeaderFooterView registerTableView:tableView indentifier:identifier];
}

- (void) registerTable:(VBaseTableView *) tableView sectionFooterIdentifier:(NSString *) identifier {
    self.sectionFooterIdentifier = identifier;
    [UITableViewHeaderFooterView registerTableView:tableView indentifier:identifier];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (self.dataSouce.count > 0) {
        return self.dataSouce.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSouce[section].rows > 0) {
        return [self.dataSouce[section].rows count];
    }
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id item = [self itemAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    [cell valueForCell:cell model:item indexPath:indexPath];
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
    
    if (self.targetModel.rows.count > 0) {
        self.clickCellBlock([self itemAtIndexPath:indexPath], indexPath);
    }else {
        self.clickCellBlock(self.targetModel, indexPath);
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if ([self.targetModel isKindOfClass:[VBaseModel class]]) {
        if (self.targetModel.cellHeight) {
            return self.targetModel.cellHeight;
        } else {
            tableView.estimatedSectionFooterHeight = 44;
            return UITableViewAutomaticDimension;
        }
    }else {
        tableView.estimatedRowHeight = 44;
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if ([self.targetModel isKindOfClass:[VBaseModel class]]) {
        if (self.targetModel.cellHeight) {
            return self.targetModel.cellHeight;
        } else {
            tableView.estimatedSectionHeaderHeight = 44;
            return UITableViewAutomaticDimension;
        }
    }else {
        tableView.estimatedRowHeight = 44;
        return UITableViewAutomaticDimension;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.sectionHeaderIdentifier];

    [sectionView valueForHeaderFooter:sectionView model:self.targetModel section:section];
    return sectionView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.sectionFooterIdentifier];
    [sectionView valueForHeaderFooter:sectionView model:self.targetModel section:section];
    return sectionView;
}

//cell 操作
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
