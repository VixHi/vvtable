//
//  VBaseTableView.m
//  VVTableView
//
//  Created by Vix Liu on 2020/4/22.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import "VBaseTableView.h"

@implementation VBaseTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark ------^_^ initView ^_^--------
- (void) initView {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}
@end
