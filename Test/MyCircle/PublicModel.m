//
//  PublicModel.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/25.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "PublicModel.h"

static NSString *userid = nil;
static NSString *token = nil;

@implementation PublicModel

+ (void)setUserid:(NSString *)str
{
    userid = str;
}
+ (NSString *)getUserid
{
    return userid;
}

+ (void)setToken:(NSString *)str
{
    token = str;
}
+ (NSString *)getToken
{
    return token;
}

+ (NSString *)getSreverPath
{
//    return @"http://192.168.1.222:9001/";
    return @"http://ensureintfc.ldxxw.com.cn:8088/";
}

+ (NSString *)getFileSreverPath
{
//    return @"http://192.168.1.222:9808/";
    return @"http://ensureapp.ldxxw.com.cn:8088/";
}

+ (NSString *)uploadFile
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getFileSreverPath],@"webservice/uploadFile"];
}


// 请求大图图片
+ (NSString *)getBigImagePath
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getFileSreverPath],@"upload/"];
}

// 请求中图图片
+ (NSString *)getMiddenImagePath
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getFileSreverPath],@"upload/midd/"];
}

// 请求小图图片
+ (NSString *)getSmallImagePath
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getFileSreverPath],@"upload/mini/"];
}

+ (NSString *)getVideoPath
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getFileSreverPath],@"upload/vedio/"];
}

+ (NSString *)getMusicPath
{
     return [NSString stringWithFormat:@"%@%@",[PublicModel getFileSreverPath],@"upload/audio/"];
}

+ (NSString *)getDianZanURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/addPostZan"];
}
+ (NSString *)getDeletePostZanURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/deletePostZan"];
}
+ (NSString *)getPostZanListURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getPostZan"];
}
+ (NSString *)getPublishURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/addPost"];
}
+ (NSString *)getDeletePostURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/deletePost"];
}
+ (NSString *)getPostDetailURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getPostDetail"];
}
+ (NSString *)getAddPostReplyURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/addPostReply"];
}
+ (NSString *)getPostReplyListURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getPostReply"];
}
+ (NSString *)getDeletePostReplyURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/deletePostReply"];
}

+ (NSString *)getAddCollectionURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/addCollection"];
}
+ (NSString *)getRemoveCollectionURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/removeCollection"];
}
+ (NSString *)getPostURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getPost"];
}
+ (NSString *)getMyPostURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getMyPost"];
}
+ (NSString *)getMyPostTypeURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getCommunityList"];
}
+ (NSString *)getUnReadCountURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getCommunityUnReadCount"];
}
+ (NSString *)getMyCommunityMessageURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getMyCommunityMessage"];
}
+ (NSString *)getPostZanURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getPostZan"];
}

// 上传医疗档案
+ (NSString *)getAddMedicalRecordURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/addMedicalRecord"];
}
// 获取医疗档案列表
+ (NSString *)getMedicalRecordListURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getMedicalRecordList"];
}
// 获取医疗档案详情
+ (NSString *)getMedicalRecordDetailURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getMedicalRecordDetail"];
}
// 编辑医疗档案
+ (NSString *)getEditMedicalRecordURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/editMedicalRecord"];
}
// 删除医疗档案
+ (NSString *)getDeleteMedicalRecordURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/deleteMedicalRecord"];
}

// 获取专家文章/视频
+ (NSString *)getExpertKnowledgeListURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getExpertKnowledgeList"];
}

+ (NSString *)getaddFriendURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/addFriend"];
}



+ (NSString *)getFriendSimpleDetailURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getFriendSimpleDetail"];
}

+ (NSString *)getPostListByMemberIdURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getPostListByMemberId"];
}

+ (NSString *)getFetalRecordListURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getFetalRecordList"];
}

// 获取理赔资料
+ (NSString *)getClaimFileListURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getClaimFileList"];
}

+ (NSString *)getUploadFileClaimURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getFileSreverPath],@"webservice/uploadFileClaim"];
}

+ (NSString *)getDowanLoadLine
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getFileSreverPath],@"upload/doc/claimApply001.doc"];
}

+ (NSString *)getRadioStationListList
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getRadioStationList"];
}

+ (NSString *)getChatBackgroundList
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getChatBackgroundList"];
}


+ (NSString *)getMemberOnlineStatusURL
{
    return [NSString stringWithFormat:@"%@%@",[PublicModel getSreverPath],@"webservice/getMemberOnlineStatus"];
}



+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    if ([stringToConvert hasPrefix:@"#"])
    {
        stringToConvert = [stringToConvert substringFromIndex:1];
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    
    if (![scanner scanHexInt:&hexNum])
    {
        return nil;
    }
    
    int r = (hexNum >> 16) & 0xFF;
    int g = (hexNum >> 8) & 0xFF;
    int b = (hexNum) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
    
}

+ (BOOL) isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSString *)getCurrentNumber:(NSInteger)count
{
    if(count <= 0)
    {
        return @"0";
    }
    else if(count > 99)
    {
        return @"99+";
    }
    else if(count > 0 && count <= 99)
    {
        return [NSString stringWithFormat:@"%ld",count];
    }
    return @"0";
}



@end
