//
//  VTableViewDataSource.m
//  VVTableView
//
//  Created by Vix Liu on 2020/4/22.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import "VTableViewDataSource.h"
#import "VBaseModel.h"
#import "UITableViewCell+vv.h"
#import "UITableViewHeaderFooterView+vv.h"


@interface VTableViewDataSource () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) NSString *headerIdentifier;
@property (nonatomic, copy) NSString *footerIdentifier;
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

    VBaseModel *model = [self.dataSouce firstObject];
     if (model.sectionArr) {
         VBaseModel *sectionModel = self.dataSouce[indexPath.section];
         return sectionModel.sectionArr[indexPath.row];
     }
    return self.dataSouce[indexPath.row];
}

- (id)sectionAtIndexPath:(NSInteger) section {
    return self.dataSouce[section];
}

- (void)register:(UITableView *) tableView identifier:(NSString *) cellIdentifier {
    
    tableView.delegate = self;
    tableView.dataSource = self;
    self.cellIdentifier = cellIdentifier;
    [UITableViewCell registerTableView:tableView indentifier:cellIdentifier];
}

- (void)register:(UITableView *) tableView identifier:(NSString *) cellIdentifier xib:(NSString *) xibName {
    
    tableView.delegate = self;
    tableView.dataSource = self;
    self.cellIdentifier = cellIdentifier;
    [tableView registerNib:[UINib nibWithNibName:xibName bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [UITableViewCell registerTableView:tableView xibIndentifier:xibName];

}

- (void)register :(UITableView *) tableView headerViewWithIdentifier:(NSString *) identifier {
    self.headerIdentifier = identifier;
    [UITableViewHeaderFooterView registerTableView:tableView indentifier:identifier];
}

- (void) register :(UITableView *) tableView headerViewWithIdentifier:(NSString *) identifier xib:(NSString *) xibName {
    self.headerIdentifier = identifier;
    [UITableViewHeaderFooterView registerTableView:tableView xibIndentifier:xibName];
}

- (void)register :(UITableView *) tableView footerViewWithIdentifier:(NSString *) identifier {
    self.footerIdentifier = identifier;
    [UITableViewHeaderFooterView registerTableView:tableView indentifier:identifier];
}

- (void) register :(UITableView *) tableView footerViewWithIdentifier:(NSString *) identifier xib:(NSString *) xibName {
    self.footerIdentifier = identifier;
    [UITableViewHeaderFooterView registerTableView:tableView xibIndentifier:xibName];
}

- (void)getDataSource: (NSArray *(^)(void)) modelArray completion: (void (^)(void)) completion {
    if (modelArray) {
        self.dataSouce = modelArray();
        if (completion) {
            completion();
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    NSAssert
    VBaseModel *model = [self.dataSouce firstObject];
    if (model.sectionArr) {
        return self.dataSouce.count;
    }
    return 1;
}

#pragma mark ------^_^ tableViewDelegate ^_^--------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    VBaseModel *model = [self.dataSouce firstObject];
     if (model.sectionArr) {
         return model.sectionArr.count;
     }
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id item = [self itemAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    [cell configure:cell model:item indexPath:indexPath];
    return cell;
}

//sectionHeader
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id item = [self sectionAtIndexPath:section];
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.headerIdentifier];
    [headerView configure:headerView model:item indexPath:section];
    return headerView;
}

//sectionFooter
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    id item = [self sectionAtIndexPath:section];
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.footerIdentifier];
    [footerView configure:footerView model:item indexPath:section];
    return footerView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    tableView.estimatedSectionHeaderHeight = 66;
    return UITableViewAutomaticDimension;
}


- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    tableView.estimatedSectionFooterHeight = 66;
    return UITableViewAutomaticDimension;
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
    if (self.clickCellBlock) {
        self.clickCellBlock(model, indexPath);
    }
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return _isCellSideSlip;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_operations == nil) {
        _operations = @[@"删除"];
    }
    NSMutableArray  *operationArr = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    for (NSString *str in _operations) {
        UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:str handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            weakSelf.editCellBlock(weakSelf.dataSouce[indexPath.row], indexPath, str);
        }];
        [operationArr addObject:rowAction];
    }
    return operationArr;
}


@end
