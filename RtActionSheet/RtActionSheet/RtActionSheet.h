//
//  RtActionSheet.h
//  RtActionSheet
//
//  Created by RuanSTao on 16/4/11.
//  Copyright © 2016年 JJS-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RtButtonItem.h"

@interface RtActionSheet : UIView

-(id)initWithCancelButtonItem:(RtButtonItem *)inCancelButtonItem destructiveButtonItem:(RtButtonItem *)inDestructiveItem otherButtonItems:(RtButtonItem *)inOtherButtonItems,...NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addButtonWithTitle:(RtButtonItem *)item;

- (void)showInView:(UIView *)view;

@property (copy, nonatomic) void(^dismissalAction)();

@end
