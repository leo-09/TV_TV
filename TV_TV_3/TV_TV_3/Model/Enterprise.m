//
//  HomeBrandModel.m
//  BTG
//
//  Created by liyy on 2017/11/20.
//  Copyright © 2017年 CCDC. All rights reserved.
//

#import "Enterprise.h"

/**
 EnterprisePic 品牌图片
 */
@implementation EnterprisePic

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{ @"prisePicID" : @"id" };
}

@end

/**
 EnterpriseBizclass 归属分类
 */
@implementation EnterpriseBizclass

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{ @"bizclassID" : @"id" };
}

@end

/**
 EnterpriseRightDto 会员权益
 */
@implementation EnterpriseRightDto

@end

/**
 Enterprise 品牌model
 */
@implementation Enterprise

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{ @"enterpriseID" : @"id" };
}

+ (NSDictionary *)objectClassInArray {
    return @{ @"banners" : [EnterprisePic class],
              @"enterpriseBizclasses" : [EnterpriseBizclass class],
              @"enterpriseRights" : [EnterpriseRightDto class] };
}

// TODO TODO TODO TODO TODO TODO
- (NSString *)culture {
    return @"全聚德，中华老字号，创建于1864年（清朝同治三年），历经几代创业拼搏获得了长足发展。1999年1月，“全聚德“被国家工商总局认定为“驰名商标”，是中国第一例服务类中国驰名商标。全聚德烤鸭肉质鲜美，适合许多人吃。 \n全聚德[1]  菜品经过不断创新发展，形成了以独具特色的全聚德烤鸭为龙头，集“全鸭席”和400多道特色菜品于一体的全聚德菜系，备受各国元首、政府官员、社会各界人士及国内外游客喜爱，被誉为“中华第一吃”。原中华人民共和国总理周恩来曾多次把全聚德“全鸭席”选为国宴。\n“全聚德”既古老又年轻，既传统又现代，正向着“中国第一餐饮，世界一流美食，国际知名品牌”宏伟愿景而奋勇前进。";
}

@end
