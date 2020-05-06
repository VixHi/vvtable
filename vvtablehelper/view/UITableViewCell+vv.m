//
//  UITableViewCell+vv.m
//  VVTableView
//
//  Created by Vix Liu on 2020/4/22.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import "UITableViewCell+vv.h"
#include <objc/objc.h>
#import "VBaseModel.h"


@implementation UITableViewCell (vv)


- (void) selectCellWithModel:(id) model indexPath:(NSIndexPath *) indexPath {
    
}

- (void) configure:(UITableViewCell *) cell model:(id) model indexPath:(NSIndexPath *) indexPath {
    VBaseModel *baseModel = model;
    self.textLabel.text = baseModel.cellText;
}



+ (void) registerTableView:(UITableView *) tableView indentifier:(NSString *) identifier {
    //通过字符串获取对应的类
    Class aClass = NSClassFromString(identifier);
    [tableView registerClass:aClass forCellReuseIdentifier:identifier];
}

+ (void) registerTableView:(UITableView *) tableView xibIndentifier:(NSString *) identifier {
    
    [tableView registerNib:[self nibWithIdentifier:identifier] forCellReuseIdentifier:identifier];
}

+ (UINib *)nibWithIdentifier:(NSString *)identifier {
    return [UINib nibWithNibName:identifier bundle:nil];
}




@end
