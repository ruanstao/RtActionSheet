//
//  RtActionSheet.m
//  RtActionSheet
//
//  Created by RuanSTao on 16/4/11.
//  Copyright © 2016年 JJS-iMac. All rights reserved.
//

#import "RtActionSheet.h"
#import "UIImageEffects.h"

#define  Height_Button (50)
#define  Height_BottomInterval (5)

//static NSString *RT_BUTTON_ASS_KEY = @"RT_BUTTON_ASS_KEY";
//static NSString *RT_DISMISSAL_ACTION_KEY = @"RT_DISMISSAL_ACTION_KEY";

@interface RtButton : UIButton
@property(nonatomic,copy)void(^clickBLock)();
@end

@implementation RtButton

@end

@interface RtActionSheet ()
@property (nonatomic,strong) NSMutableArray *otherButtonArray;
@property (nonatomic,strong) NSMutableArray *destructiveButtonArray;
@property (nonatomic,strong) NSMutableArray *cancelButtonArray;

@property (nonatomic, strong) UIView *bgView;
@end

@implementation RtActionSheet

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(id)initWithCancelButtonItem:(RtButtonItem *)inCancelButtonItem destructiveButtonItem:(RtButtonItem *)inDestructiveItem otherButtonItems:(RtButtonItem *)inOtherButtonItems,...
{
    self = [super init];
    if (self)
    {
        NSMutableArray *buttonsArray = [NSMutableArray array];

        RtButtonItem *eachItem;
        va_list argumentList;
        if (inOtherButtonItems)
        {
            [buttonsArray addObject: inOtherButtonItems];
            va_start(argumentList, inOtherButtonItems);
            while((eachItem = va_arg(argumentList, RtButtonItem *)))
            {
                [buttonsArray addObject: eachItem];
            }
            va_end(argumentList);
        }
        self.otherButtonArray = buttonsArray;
        if (inDestructiveItem) {
            self.destructiveButtonArray =[NSMutableArray arrayWithArray:@[inDestructiveItem]];
        }else{
            self.destructiveButtonArray =[NSMutableArray array];
        }
        if (inCancelButtonItem) {
            self.cancelButtonArray = [NSMutableArray arrayWithArray:@[inCancelButtonItem]];
        }else{
            self.cancelButtonArray = [NSMutableArray array];
        }

    }
    return self;
}

- (NSInteger)addButtonWithTitle:(RtButtonItem *)item
{

    [self.otherButtonArray addObject:item];
    return self.otherButtonArray.count;
}

- (void)showInView:(UIView *)view
{
    self.frame = view.bounds;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheet)];
    [self addGestureRecognizer:tap];

    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height, view.frame.size.width, (self.otherButtonArray.count + self.destructiveButtonArray.count + self.cancelButtonArray.count) * (Height_Button + 1) + Height_BottomInterval)];
    _bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImageEffects imageByApplyingExtraLightEffectToImage:[UIImageEffects captureWithFrame:CGRectMake(0, 0, self.bgView.frame.size.width, self.bgView.frame.size.height)]]];
    [self addSubview:_bgView];
    CGFloat y = 0;
    for (int i = 0; i < self.otherButtonArray.count; i++) {
        [self createBtnWithTitle:self.otherButtonArray[i] origin_y:y width:self.bgView.frame.size.width textColor:[UIColor blackColor] block:^{
            RtButtonItem *btn = self.otherButtonArray[i];
            if (btn.action) {
                btn.action();
            }
        }];
        y += Height_Button + 1;
    }
    for (int i = 0; i < self.destructiveButtonArray.count; i++) {
        [self createBtnWithTitle:self.destructiveButtonArray[i] origin_y:y width:self.bgView.frame.size.width textColor:[UIColor redColor] block:^{
            RtButtonItem *btn = self.destructiveButtonArray[i];
            if (btn.action) {
                btn.action();
            }
        }];
        y += Height_Button + 1;
    }
    y += Height_BottomInterval;
    for (int i = 0; i < self.cancelButtonArray.count; i++) {
        [self createBtnWithTitle:self.cancelButtonArray[i] origin_y:y width:self.bgView.frame.size.width textColor:[UIColor blackColor] block:^{
            RtButtonItem *btn = self.cancelButtonArray[i];
            if (btn.action) {
                btn.action();
            }
        }];
        y += Height_Button + 1;
    }

    [view addSubview:self];

    [self setBackgroundColor:[UIColor colorWithWhite:0.3 alpha:0]];
    [UIView animateWithDuration:0.3 animations:^{
        [self setBackgroundColor:[UIColor colorWithWhite:0.3 alpha:0.3]];
        CGRect frame = _bgView.frame;
        frame.origin.y -= frame.size.height;
        _bgView.frame = frame;
    }];
}

- (void)createBtnWithTitle:(RtButtonItem *)item origin_y:(CGFloat)y width:(CGFloat)width textColor:(UIColor *)color  block:(void(^)())block {
    RtButton *btn = [RtButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:item.label forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, y, width, Height_Button);
    btn.backgroundColor = [UIColor whiteColor];
    [btn setBackgroundImage:[self imageWithColor:[UIColor whiteColor] Size:CGRectMake(0, 0, CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame))] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self imageWithColor:[UIColor lightGrayColor] Size:CGRectMake(0, 0, CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame))] forState:UIControlStateHighlighted];

    btn.clickBLock = block;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:btn];
}

- (UIImage *)imageWithColor:(UIColor *)color Size:(CGRect)size
{
    CGRect rect = size;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (void)click:(RtButton *)btn {
    if (btn.clickBLock) {
        btn.clickBLock();
    }
    [self hiddenSheet];
}

- (void)hiddenSheet {
    [UIView animateWithDuration:0.3 animations:^{
        [self setBackgroundColor:[UIColor clearColor]];
        CGRect frame = _bgView.frame;
        frame.origin.y += frame.size.height;
        _bgView.frame = frame;
    }completion:^(BOOL finished) {
        if (self.dismissalAction) {
            self.dismissalAction();
        }
        [self removeFromSuperview];
    }];
}


@end
