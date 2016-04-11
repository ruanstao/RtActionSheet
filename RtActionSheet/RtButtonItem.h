//
//  RtButtonItem.h
//  RtActionSheet
//
//  Created by RuanSTao on 16/4/11.
//  Copyright © 2016年 JJS-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RtButtonItem : NSObject
{
    NSString *label;
    void (^action)();
}
@property (retain, nonatomic) NSString *label;
@property (copy, nonatomic) void (^action)();
+(id)item;
+(id)itemWithLabelString:(NSString *)inLabel;
+(id)itemWithLabelString:(NSString *)inLabel action:(void(^)(void))action;

@end
