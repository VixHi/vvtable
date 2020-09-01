//
//  VTestCell.m
//  vvtable
//
//  Created by Vix Liu on 2020/5/11.
//  Copyright © 2020 Vix Liu. All rights reserved.
//

#import "VTestCell.h"
#import "UITableViewCell+vv.h"
#import "VBaseModel.h"

@interface VTestCell ()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *content;

@end

@implementation VTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView {
    __weak typeof(self) weakSelf = self;

    _title = [UILabel new];
    [self addSubview:_title];
    _title.font = [UIFont boldSystemFontOfSize:20];
    _title.textColor = [UIColor blackColor];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(15);
        make.width.offset(200);
        make.height.offset(30);
    }];
    
    _content = [UILabel new];
    [self addSubview:_content];
    _content.font = [UIFont systemFontOfSize:14];
    _content.textColor = [UIColor grayColor];
    _content.text = @"数息树身边";
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(weakSelf.title.mas_bottom).offset(5);
        make.width.offset(200);
        make.height.offset(30);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
    }];
}

- (void)valueForCell:(UITableViewCell *)cell model:(id)model indexPath:(NSIndexPath *)indexPath {
    VBaseModel *baseModel = model;
    _title.text = baseModel.cellText;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
