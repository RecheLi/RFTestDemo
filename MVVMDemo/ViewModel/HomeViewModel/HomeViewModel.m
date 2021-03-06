//
//  HomeViewModel.m
//  RFTestDemo
//
//  Created by linitial on 2018/4/2.
//  Copyright © 2018年 redfinge. All rights reserved.
//

#import "HomeViewModel.h"

@interface HomeViewModel ()

@property (nonatomic, readwrite, strong) NSMutableArray *dataSource;


@end

@implementation HomeViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = [[Box alloc]initWithValue: @"首页"];
    }
    return self;
}

// 请求获取数据
- (void)getDataSuccess:(void(^)(NSArray *data))succeed
                failed:(void(^)(NSError *error))failed {
    // 获取数据
    for (int i=0; i<10; ++i) {
        HomeModel *model = [HomeModel new];
        model.title = [NSString stringWithFormat:@"豌豆射手 > %@", @(i)];
        model.subtitle = [NSString stringWithFormat:@"< 僵尸僵尸 %@", @(i)];
        HomeCellViewModel *cViewModel = [[HomeCellViewModel alloc]initWithHomeModel:model];
        [self.dataSource addObject:cViewModel];
    }
    
    if (self.dataSource.count==0 && failed) {
        NSError *error = [NSError errorWithDomain:@"no data" code:-1 userInfo:nil];
        failed(error);
        return;
    }
    if (succeed) {
        succeed(_dataSource);
    }
    [self changeViewModel];
}

- (void)changeViewModel {
    // viewmode数据改变
    if (self.listener) {
        self.listener(self.dataSource);
    }
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
