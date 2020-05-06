//
//  UITableViewCell+vv.h
//  VVTableView
//
//  Created by Vix Liu on 2020/4/22.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (vv)

/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 cell赋值
 !**/
- (void) configure:(UITableViewCell *) cell model:(id) model indexPath:(NSIndexPath *) indexPath;

/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 cell的点击事件
 !**/
- (void) selectCellWithModel:(id) model indexPath:(NSIndexPath *) indexPath;

/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 设置tableview 注册代码cell
 !**/
+ (void) registerTableView:(UITableView *) tableView indentifier:(NSString *) identifier;

/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 设置tableview 注册xibcell
 !**/
+ (void) registerTableView:(UITableView *) tableView xibIndentifier:(NSString *) identifier;


@end

NS_ASSUME_NONNULL_END
