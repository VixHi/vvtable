//
//  VTableViewDataSource.h
//  VVTableView
//
//  Created by Vix Liu on 2020/4/22.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface VTableViewDataSource : NSObject 


/****
★ ☆ ★
 register tableView 、cell
 warning: cellIdentifier 必须与cell的类名一致
 !**/
- (void) register :(UITableView *) tableView identifier:(NSString *) cellIdentifier;


/****
★ ☆ ★
register tableview、xib文件
waring:  xibName 必须和xib文件名一致
!**/
- (void) register :(UITableView *) tableView identifier:(NSString *) cellIdentifier xib:(NSString *) xibName;

/****
★ ☆ ★
register tableview、headerView
waring:  identifier 必须和注册view的类名一致
!**/
- (void)register :(UITableView *) tableView headerViewWithIdentifier:(NSString *) identifier;

/****
★ ☆ ★
register tableview、headerView
waring:  identifier 必须和注册view的类名一致, xibName 必须和xib文件名一致
!**/
- (void) register :(UITableView *) tableView headerViewWithIdentifier:(NSString *) identifier xib:(NSString *) xibName;



/****
★ ☆ ★
register tableview、FooterView
waring:  identifier 必须和注册view的类名一致
!**/
- (void)register :(UITableView *) tableView footerViewWithIdentifier:(NSString *) identifier;

/****
★ ☆ ★
register tableview、FooterView
waring:  identifier 必须和注册view的类名一致, xibName 必须和xib文件名一致
!**/
- (void) register :(UITableView *) tableView footerViewWithIdentifier:(NSString *) identifier xib:(NSString *) xibName;


/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 数据源
 example：
 [self.datasource getDataSource:^NSArray * _Nonnull{
 //返回数据源
     return self.dataArr;
 } completion:^{
 //完成对cell赋值之后的对tableview的操作
     [self.tableView reloadData];
 }];
 
 !**/
- (void) getDataSource: (NSArray *(^)(void)) modelArray completion: (void (^)(void)) completion;

/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 cell点击事件
 !**/
@property (nonatomic, copy) void  (^clickCellBlock)(id model, NSIndexPath *indexPath);






/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 cell 编辑
 isCellSideSlip YES 可以测滑操作 NO 不可以
 operations 默认是删除，可自定义多个操作项 例如：@[@"删除", @"编辑", @"置顶"];
 operation: 点击的选项
 !**/
@property (nonatomic, assign) BOOL  isCellSideSlip;
@property (nonatomic, strong) NSArray  *operations;
@property (nonatomic, copy) void  (^editCellBlock)(id model, NSIndexPath *indexPath, NSString *operation);





@end

NS_ASSUME_NONNULL_END
