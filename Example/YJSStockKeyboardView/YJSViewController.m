//
//  YJSViewController.m
//  YJSStockKeyboardView
//
//  Created by YuanJiaShuai on 05/10/2021.
//  Copyright (c) 2021 YuanJiaShuai. All rights reserved.
//

#import "YJSViewController.h"
#import "YJSKeyboardView.h"

@interface YJSViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation YJSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [YJSKeyboardView directToReverseTextFiledInputView:self.tf keyboardViewType:YJSKeyboardViewType_Custom_Number];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
