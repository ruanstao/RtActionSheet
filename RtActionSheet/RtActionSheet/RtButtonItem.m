//
//  RtButtonItem.m
//  RtActionSheet
//
//  Created by RuanSTao on 16/4/11.
//  Copyright © 2016年 JJS-iMac. All rights reserved.
//

#import "RtButtonItem.h"

@implementation RtButtonItem
@synthesize label;
@synthesize action;
+(id)item
{
    return [self new];
}

+(id)itemWithLabelString:(NSString *)inLabel
{
    RtButtonItem *newItem = [self item];
    [newItem setLabel:inLabel];
    return newItem;
}

+(id)itemWithLabelString:(NSString *)inLabel action:(void(^)(void))action
{
    RtButtonItem *newItem = [self itemWithLabelString:inLabel];
    [newItem setAction:action];
    return newItem;
}
@end
