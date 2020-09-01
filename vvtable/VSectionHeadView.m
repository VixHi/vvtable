//
//  VSectionHeadView.m
//  vvtable
//
//  Created by Vix Liu on 2020/5/11.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import "VSectionHeadView.h"
#import "UITableViewHeaderFooterView+vv.h"
#import "VBaseModel.h"

@interface VSectionHeadView ()

@property (nonatomic, strong) UILabel *sectionTitle;

@end

@implementation VSectionHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        
    }
    return self;
}

- (void)initView {
    _sectionTitle = [UILabel new];
    [self addSubview:_sectionTitle];
    _sectionTitle.font = [UIFont boldSystemFontOfSize:16];
    _sectionTitle.textColor = [UIColor blackColor];
    _sectionTitle.textAlignment = NSTextAlignmentCenter;
    [_sectionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(15);
        make.right.offset(-15);
        make.height.offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
    }];
}

- (void) valueForHeaderFooter:(UITableViewHeaderFooterView *) view model:(id) model section:(NSInteger) section {
//    VBaseModel *baseModel = model;
//    _sectionTitle.text = [NSString stringWithFormat:@"%@", baseModel.cellText];
    _sectionTitle.text = [NSString stringWithFormat:@"第%ld个分区END", section];

}

@end
