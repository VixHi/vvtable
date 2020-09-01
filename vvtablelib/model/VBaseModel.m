//
//  VBaseModel.m
//  VVTableView
//
//  Created by Vix Liu on 2020/4/22.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import "VBaseModel.h"

@implementation VBaseModel


- (NSMutableArray *)rows {
    
    if (!_rows) {
        _rows = [NSMutableArray array];
    }
    return _rows;
}


@end
