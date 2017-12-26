//
//  HomeBrandModel.h
//  BTG
//
//  Created by liyy on 2017/11/20.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 EnterprisePic 品牌图片
 */
@interface EnterprisePic : NSObject

@property (nonatomic, copy) NSString *enable;       // 状态（0：禁用，1：启用）
@property (nonatomic, copy) NSString *entId;        // 品牌id
@property (nonatomic, copy) NSString *prisePicID;   // ID
@property (nonatomic, copy) NSString *picture;      // 图片路径

@end

/**
 EnterpriseBizclass 归属分类
 */
@interface EnterpriseBizclass : NSObject

@property (nonatomic, copy) NSString *bizclassID;   // ID
@property (nonatomic, copy) NSString *bizclassId;   // 业态id
@property (nonatomic, copy) NSString *bizclassName; // 业态名称
@property (nonatomic, copy) NSString *entId;        // 品牌id
@property (nonatomic, copy) NSString *parentBizclassName;   // 父业态名称
@property (nonatomic, assign) NSInteger parentBizclassId;   // 父业态id
@property (nonatomic, copy) NSString *enable;       // 状态（0：禁用，1：启用）

@end

/**
 EnterpriseRightDto 会员权益
 */
@interface EnterpriseRightDto : NSObject

@property (nonatomic, copy) NSString *entId;        // 品牌id
@property (nonatomic, copy) NSString *entName;      // 品牌名称
@property (nonatomic, copy) NSString *levelPoints;  // 会员:积分
@property (nonatomic, copy) NSString *rightId;      // 权益id
@property (nonatomic, copy) NSString *rightName;    // 权益名称

@end

/**
 Enterprise 品牌model
 */
@interface Enterprise : NSObject

@property (nonatomic, copy) NSString *enterpriseID; // ID
@property (nonatomic, copy) NSString *culture;      // 品牌文化
@property (nonatomic, copy) NSString *entLogo;      // logo
@property (nonatomic, copy) NSString *entName;      // 品牌名称
@property (nonatomic, copy) NSString *fullName;     // 品牌全称
@property (nonatomic, assign) NSInteger entType;    // 品牌类型（0：吃1：住2：行3：游4：购5：娱）
@property (nonatomic, assign) NSInteger slFlag;     // 是否首旅品牌(0:是1：不是)
@property (nonatomic, copy) NSString *enable;       // 状态（0：禁用，1：启用)
@property (nonatomic, assign) NSInteger entAttr;    // 品牌属性（关联数据字典）
@property (nonatomic, strong) NSArray<EnterprisePic *> *banners;
@property (nonatomic, strong) NSArray<EnterpriseBizclass *> *enterpriseBizclasses;    // 归属分类
@property (nonatomic, strong) NSArray<EnterpriseRightDto *> *enterpriseRights;        // 会员权益

//@property (nonatomic, assign) int weight;       // 权重
//@property (nonatomic, assign) CGFloat radius;   // 半径
//@property (nonatomic, assign) CGPoint center;   // 圆心
//@property (nonatomic, assign) CGRect frame;     // frame

@end
