//
//  VTableViewDataSource.h
//  VVTableView
//
//  Created by Vix Liu on 2020/4/22.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VBaseTableView;

@interface VTableViewDataSource : NSObject 


/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※

 注册tableview和cell
 !**/
- (void) registerTableView:(VBaseTableView *) tableView cellIdentifier:(NSString *) identifier;

/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
注册tableview和 xib文件
 !**/
- (void) registerTableView:(VBaseTableView *) tableView cellIdentifier:(NSString *) identifier xib:(NSString *) xibName;



/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
注册SectionHeaderView
 !**/
- (void) registerTable:(VBaseTableView *) tableView sectionHeaderIdentifier:(NSString *) identifier;

/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
注册SectionHeaderView
 !**/
- (void) registerTable:(VBaseTableView *) tableView sectionFooterIdentifier:(NSString *) identifier;


/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 数据源 对cell赋值
 !**/
- (void) cellForData: (id(^)(void)) modelArray completion: (void (^)(void)) completion;

/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 cell点击事件
 !**/
@property (nonatomic, copy) void  (^clickCellBlock)(id model, NSIndexPath *indexPath);


/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 cell 编辑
 isCellSideSlip YES 可以测滑操作 NO 不可以
 editStr 默认是删除，可自定义多个操作项 例如：@[@"删除", @"编辑", @"置顶"];
 operation: 点击的选项
 !**/
@property (nonatomic, assign) BOOL  isCellSideSlip;
@property (nonatomic, copy) NSArray  *editStrs;
@property (nonatomic, copy) void  (^editCellBlock)(id model, NSIndexPath *indexPath, NSString *operation);


@end

NS_ASSUME_NONNULL_END
