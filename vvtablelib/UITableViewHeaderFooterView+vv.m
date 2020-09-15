//
//  UITableViewHeaderFooterView+vv.m
//  vvtable
//
//  Created by Vix Liu on 2020/5/11.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import "UITableViewHeaderFooterView+vv.h"
#include <objc/objc.h>
#import "VBaseModel.h"

@implementation UITableViewHeaderFooterView (vv)


- (void) valueForHeaderFooter:(UITableViewHeaderFooterView *) view model:(id) model section:(NSInteger) section {

}

+ (void) registerTableView:(UITableView *) tableView indentifier:(NSString *) identifier {
    //通过字符串获取对应的类
    Class aClass = NSClassFromString(identifier);
    NSAssert(aClass != nil, @"无效headerFooterIdentifier");
    [tableView registerClass:aClass forHeaderFooterViewReuseIdentifier:identifier];
}

+ (void) registerTableView:(UITableView *) tableView xibIndentifier:(NSString *) identifier {
    [tableView registerNib:[self nibWithIdentifier:identifier] forHeaderFooterViewReuseIdentifier:identifier];
}

+ (UINib *)nibWithIdentifier:(NSString *)identifier {
    return [UINib nibWithNibName:identifier bundle:nil];
}



@end
