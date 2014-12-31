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
             [GoodsDetailInfoRowObject shareWithTitle:@"如何购买" value:@"_____"]
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
        self.backgroundColor = V_COLOR(241, 242, 246, 1.0);
        self.model = model;
        self.dataSource = [GoodsDetailInfoRowObject arrayWithModel:model];
        self.listView.frame = self.bounds;
        self.listView.scrollEnabled = YES;
        [self addSubview:self.listView];
        UIScrollView *s = (UIScrollView *)self.superview;
        CGFloat origion = CGRectGetMinY(self.frame);
        CGFloat height = [self totalHeight] + 40;
        self.height = height;
        DLog("Total Height = %f", [self totalHeight]);
        self.listView.frame = self.bounds;
        s.contentSize = CGSizeMake(s.width, origion + self.height);
    }
    return self;
}

#pragma mark - properties

- (UITableView *)listView
{
    if (!_listView) {
        _listView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            tableView.dataSource = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
            headerView.text = @"     商 品 详 情";
            headerView.textColor = [UIColor colorWithHexString:@"#434a54"];
            headerView.backgroundColor = V_COLOR(252, 252, 253, 1.0);
            tableView.tableHeaderView = headerView;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView;
        });
    }
    return _listView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goodsCell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [self stringWihtIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#434a54"];
    return cell;
}

- (NSString *)stringWihtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row / 2;
    GoodsDetailInfoRowObject *object = self.dataSource[index];
    if ((indexPath.row % 2) % 2 == 1) {
        return object.defaultValue;
    }else{
        return [NSString stringWithFormat:@"%@:",object.title];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = [self stringWihtIndexPath:indexPath];
    CGSize size = BT_TEXTSIZE(string, [UIFont systemFontOfSize:15]);
    return size.height;
}

//- (void)totalHeihgt
//{
//    CGFloat height = 0;
//    height +
//}
- (CGFloat)stringHeight:(NSString *)string
{
    CGSize size = BT_TEXTSIZE(string, [UIFont systemFontOfSize:15]);
    return MAX(size.height,40);
}

- (CGFloat)totalHeight
{
    __block CGFloat height = 0;
    [self.dataSource enumerateObjectsUsingBlock:^(GoodsDetailInfoRowObject *obj, NSUInteger idx, BOOL *stop) {
        height += [self stringHeight:[NSString stringWithFormat:@"%@:",obj.title]];
        height += [self stringHeight:obj.defaultValue];
    }];
    return height;
}

@end
