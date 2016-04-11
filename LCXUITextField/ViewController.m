//
//  ViewController.m
//  LCXUITextField
//
//  Created by buTing on 16/1/7.
//  Copyright © 2016年 buTing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSMutableString *IDCardStringForPostPram;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(40, 60, 320, 40)];
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    tf.backgroundColor = [UIColor whiteColor];
    tf.placeholder = @"please input";
    tf.delegate = (id) self;
    [self.view addSubview:tf];
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (IDCardStringForPostPram == nil) {
        IDCardStringForPostPram = [[NSMutableString alloc] initWithCapacity:0];
    }
    [IDCardStringForPostPram appendString:string ];
    NSLog(@"1st IDCardStringForPostPram ->%@",IDCardStringForPostPram);

    static NSUInteger Lct =0;

    NSLog(@"replacementString-> %@",string);
    NSLog(@"range.location-> %lu  lct-> %lu",range.location,Lct);
    if (range.location<Lct) {// 退格键
        NSLog(@"it is delete");
        Lct--;
        NSLog(@"After delete range.location-> %lu  lct-> %lu",range.location,Lct);
        NSLog(@"2ed IDCardStringForPostPram ->%@",IDCardStringForPostPram);
//        NSString *str=[NSString stringWithFormat:@"%@",IDCardStringForPostPram];
//        NSRange rangeOfIDStr=NSRangeFromString(str);
        
//        NSLog(@"rangeOfIDStr range -> %lu %lu",rangeOfIDStr.location,rangeOfIDStr.length);
        NSRange rangeForCut=NSMakeRange(range.location, IDCardStringForPostPram.length-range.location);
        NSLog(@"rangeForCut range -> %lu %lu",range.location,IDCardStringForPostPram.length-range.location);
[IDCardStringForPostPram deleteCharactersInRange:rangeForCut];


        return YES;
    }
    if([string isEqualToString:@" "]){//空格键
        NSLog(@"it is blank space");
        NSLog(@"After blank space range.location-> %lu  lct-> %lu",range.location,Lct);
        return NO;
    }
    Lct++;

    if (range.location>3&&range.location<13) {//处理指定位置的***号隐私
        NSLog(@"come in ");
        
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:@"*"]; //将当前的输入文字替换为自定义的@"*"
        textField.text=toBeString;//重设输入框的内容
        return NO;
    }
    if (range.location>18) {
        NSLog(@"more than 18");
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSRange range=NSMakeRange(0, IDCardStringForPostPram.length);

        [IDCardStringForPostPram deleteCharactersInRange:range];
    NSLog(@"textFieldShouldClear  IDCardStringForPostPram ->%@",IDCardStringForPostPram);
    return YES;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    
    return YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
