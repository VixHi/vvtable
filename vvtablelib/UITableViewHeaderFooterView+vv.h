//
//  UITableViewHeaderFooterView+vv.h
//  vvtable
//
//  Created by Vix Liu on 2020/5/11.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewHeaderFooterView (vv)

/* ***
 
 view 赋值
 !**/
- (void) valueForHeaderFooter:(UITableViewHeaderFooterView *) view model:(id) model section:(NSInteger) section;


/* ***

 设置tableview 注册headerFooterView
 !**/
+ (void) registerTableView:(UITableView *) tableView indentifier:(NSString *) identifier;


/* ***

 设置tableview 注册xibView
 !**/
+ (void) registerTableView:(UITableView *) tableView xibIndentifier:(NSString *) identifier;





@end

NS_ASSUME_NONNULL_END
