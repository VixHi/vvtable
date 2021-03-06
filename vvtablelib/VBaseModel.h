//
//  VBaseModel.h
//  VVTableView
//
//  Created by Vix Liu on 2020/4/22.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VBaseModel : NSObject



/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 自己的逻辑
 可以自己计算sectionHeaderHeight多高度
 
 自动计算高度时将sectionHeaderHeight设置为0
 !**/
@property (nonatomic, assign) float  sectionHeaderHeight;

/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 自己的逻辑
 可以自己计算sectionFooterHeight多高度
 
 自动计算高度时将sectionFooterHeight设置为0
 !**/
@property (nonatomic, assign) float  sectionFooterHeight;


/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 自己的逻辑
 可以自己计算cell多高度
 
 自动计算高度时将cellHeight设置为0
 !**/
@property (nonatomic, assign) float  cellHeight;

/****
 ※ ※ ※ ※ ※ ※ ※ ※ ★ ☆ ★ ※ ※ ※ ※ ※ ※ ※ ※
 使用系统UItableviewCell时对此属性赋值
 配置UItableViewCell 使用UITableView时对cell赋值
 !**/
@property (nonatomic, copy) NSString  *cellText;

/***
 
 section > 1
 rows 数据源
 */
@property (nonatomic, strong) NSMutableArray *rows;

@end

NS_ASSUME_NONNULL_END
