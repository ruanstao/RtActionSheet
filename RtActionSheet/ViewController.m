//
//  ViewController.m
//  RtActionSheet
//
//  Created by RuanSTao on 16/4/11.
//  Copyright © 2016年 JJS-iMac. All rights reserved.
//

#import "ViewController.h"
#import "RtActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    - (instancetype)initWithTitle:(nullable NSString *)title delegate:(nullable id<UIActionSheetDelegate>)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ...

//    RIButtonItem * r = [RIButtonItem itemWithLabel:@"af" action:^{
//        NSLog(@"2e");
//    }];
//    UIActionSheet *act = [[UIActionSheet alloc] initWithTitle:@"asdf" cancelButtonItem:r destructiveButtonItem:r otherButtonItems:r, nil];
//    [act showInView:self.view];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showSheet:(id)sender {
    RtButtonItem *cancel = [RtButtonItem itemWithLabelString:@"cancel" action:^{
        NSLog(@"cancel");
    }];
    RtButtonItem *destructiv = [RtButtonItem itemWithLabelString:@"destructive" action:^{
        NSLog(@"destructive");
    }];
    RtButtonItem *otherButton = [RtButtonItem itemWithLabelString:@"otherButton" action:^{
        NSLog(@"otherButton");
    }];
    RtButtonItem *otherButton2 = [RtButtonItem itemWithLabelString:@"otherButton2" action:^{
        NSLog(@"otherButton");
    }];
    RtActionSheet *a = [[RtActionSheet alloc] initWithCancelButtonItem:cancel destructiveButtonItem:destructiv otherButtonItems:otherButton,otherButton2,nil];
    [a showInView:self.view];
}
@end
