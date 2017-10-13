//
//  PublicModel.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/25.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PublicModel : NSObject

+ (void)setUserid:(NSString *)str;
+ (NSString *)getUserid;

+ (void)setToken:(NSString *)str;
+ (NSString *)getToken;

// 服务器
+ (NSString *)getSreverPath;
// 文件
+ (NSString *)getFileSreverPath;
// 请求大图图片
+ (NSString *)getBigImagePath;
// 请求中图图片
+ (NSString *)getMiddenImagePath;
// 请求小图图片
+ (NSString *)getSmallImagePath;



// 上传图片
+ (NSString *)uploadFile;
// 宝妈圈点赞
+ (NSString *)getDianZanURL;
// 宝妈圈取消点赞
+ (NSString *)getDeletePostZanURL;
// 获取点赞列表
+ (NSString *)getPostZanListURL;
// 发表帖子
+ (NSString *)getPublishURL;
// 删除帖子
+ (NSString *)getDeletePostURL;
// 获取帖子详情
+ (NSString *)getPostDetailURL;
// 发布评论
+ (NSString *)getAddPostReplyURL;
// 获取评论列表
+ (NSString *)getPostReplyListURL;
// 删除评论
+ (NSString *)getDeletePostReplyURL;
// 我的收藏
+ (NSString *)getAddCollectionURL;
// 取消收藏
+ (NSString *)getRemoveCollectionURL;
// 获取全部帖子列表
+ (NSString *)getPostURL;
// 获取我的帖子列表
+ (NSString *)getMyPostURL;
// 获取帖子类别
+ (NSString *)getMyPostTypeURL;
// 获取社区未读消息
+ (NSString *)getUnReadCountURL;
// 获取社区消息列表 1:评论消息，2:点赞消息
+ (NSString *)getMyCommunityMessageURL;
// 获取点赞列表 还没用
+ (NSString *)getPostZanURL;
// 上传医疗档案
+ (NSString *)getAddMedicalRecordURL;
// 获取医疗档案列表
+ (NSString *)getMedicalRecordListURL;
// 获取医疗档案详情
+ (NSString *)getMedicalRecordDetailURL;
// 编辑医疗档案
+ (NSString *)getEditMedicalRecordURL;
// 删除医疗档案
+ (NSString *)getDeleteMedicalRecordURL;
// 获取专家文章/视频
+ (NSString *)getExpertKnowledgeListURL;
// 获取视频的专用接口
+ (NSString *)getVideoPath;
// 获取音乐的专用接口
+ (NSString *)getMusicPath;
// 添加好友的接口
+ (NSString *)getaddFriendURL;
//获取好友简单信息
+ (NSString *)getFriendSimpleDetailURL;
//获取其他会员帖子
+ (NSString *)getPostListByMemberIdURL;
// 获取音乐的接口
+ (NSString *)getFetalRecordListURL;

// 上传理赔资料
+ (NSString *)getUploadFileClaimURL;
// 获取理赔资料
+ (NSString *)getClaimFileListURL;

+ (NSString *)getDowanLoadLine;

+ (NSString *)getRadioStationListList;

+ (NSString *)getChatBackgroundList;

+ (NSString *)getMemberOnlineStatusURL;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (BOOL) isBlankString:(NSString *)string;
+ (NSString *)getCurrentNumber:(NSInteger)count;
@end
