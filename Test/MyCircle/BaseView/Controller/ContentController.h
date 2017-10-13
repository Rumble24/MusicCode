//
//  ContentController.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *tieZiId;

// 1.这个是从Unity直接查看详情 2.这个是从帖子查看详情  3.从个人中心查看详情
//          Unity              Teizi                GeRen
@property (nonatomic, strong) NSString *pushType;


/**
 *  记录当前点击的indexPath
 */
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@end
