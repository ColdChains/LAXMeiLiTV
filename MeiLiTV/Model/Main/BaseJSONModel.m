//
//  BaseJSONModel.m
//  DYZBQFReplica
//
//  Created by 王博 on 16/5/15.
//  Copyright © 2016年 wangbo. All rights reserved.
//

#import "BaseJSONModel.h"

@implementation BaseJSONModel

//字典中的key 值个数少于模型属性时，导致key和属性不匹配，属性值为空的，会崩溃，需要忽略属性，正常赋值
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

//字典中key与属性名不一致时，通过字典的形式固定赋值的对应关系，模型的属性名作为Key 字典中的key名作为value
//+(JSONKeyMapper *)keyMapper{
//    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"createDate":@"create_date",@"Description":@"description",@"Id":@"id"}];
//}

@end
