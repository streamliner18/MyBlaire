//
//  MBGoodsDetailInfoView.m
//  MB
//
//  Created by Tongtong Xu on 14/11/23.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBGoodsDetailInfoView.h"
#import "MBProductModel.h"

@interface GoodsDetailInfoRowObject : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *defaultValue;
@end

@implementation GoodsDetailInfoRowObject

+ (instancetype)shareWithTitle:(NSString *)title value:(NSString *)defaultValue
{
    GoodsDetailInfoRowObject *object = [[GoodsDetailInfoRowObject alloc] init];
    object.title = title;
    object.defaultValue = defaultValue;
    return object;
}

+ (NSArray *)arrayWithModel:(MBProductModel *)model
{
    return @[
             [GoodsDetailInfoRowObject shareWithTitle:@"材质" value:model.materialQuality],
             [GoodsDetailInfoRowObject shareWithTitle:@"颜色" value:model.color],
             [GoodsDetailInfoRowObject shareWithTitle:@"描述" value:model.goodDesc],
             [GoodsDetailInfoRowObject shareWithTitle:@"购买链接" value:model.buyURL?model.buyURL:@""],
             [GoodsDetailInfoRowObject shareWithTitle:@"如何购买" value:@""]
             ];
}
@end

@interface MBGoodsDetailInfoView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) MBProductModel *model;
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation MBGoodsDetailInfoView

- (instancetype)initWithFrame:(CGRect)frame model:(MBProductModel *)model
{
    if (self = [super initWithFrame:frame]) {
        self.model = model;
        self.dataSource = [GoodsDetailInfoRowObject arrayWithModel:model];
        self.listView.frame = CGRectMake(0, 100, self.width, 280);
        self.listView.scrollEnabled = NO;
        [self addSubview:self.listView];
        
        @weakify(self);
        [self bk_whenTapped:^{
            @strongify(self);
            [self removeFromSuperview];
        }];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(self.listView.frame, point)) {
        [(UIGestureRecognizer *)[self.gestureRecognizers firstObject] setEnabled:NO];
        return self.listView;
    }
    [(UIGestureRecognizer *)[self.gestureRecognizers firstObject] setEnabled:YES];
    return [super hitTest:point withEvent:event];
}

#pragma mark - properties

- (UITableView *)listView
{
    if (!_listView) {
        _listView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
            headerView.text = @"  商品详情";
            tableView.tableHeaderView = headerView;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView;
        });
    }
    return _listView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goodsCell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    GoodsDetailInfoRowObject *object = self.dataSource[indexPath.row];
    cell.textLabel.text = [object.title stringByAppendingFormat:@":    %@",object.defaultValue];
    return cell;
}

@end
