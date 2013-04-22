//
//  ViewController.m
//  amoyTask
//
//  Created by wuliang on 13-4-11.
//  Copyright (c) 2013年 wuliang. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"

#import "RegisterAction.h"
#import "LoginAction.h"

#import "Prompt.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //区分登录与注册
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"YES" forKey:@"register"];
    
    NSString *isRegister = [defaults objectForKey:@"register"];

    
    float height = 0;
    float distance = 0;
    NSString *buttonTitle = @"";
    if ([isRegister isEqualToString:@"YES"]) {
        isRegistered = YES;
        height = 260;
        distance = 120;
        buttonTitle = @"登录";
    } else {
        isRegistered = NO;
        height = 200;
        distance = 180;
        buttonTitle = @"注册";
    }
    
    //userName
    userName = [[UITextField alloc] initWithFrame:CGRectMake(50, height, 220, 43)];
    userName.placeholder = @"用户名";
    //userName.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"type.png"]];
    //userName.leftViewMode = UITextFieldViewModeAlways;
    userName.font = [UIFont fontWithName:@"Helvetica" size:30];
    userName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"textbg.png"]];
    userName.borderStyle = UITextBorderStyleNone;
    userName.keyboardType = UIKeyboardTypeNamePhonePad;
    userName.returnKeyType = UIReturnKeyDone;
    userName.textAlignment = NSTextAlignmentLeft;
    userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    userName.delegate = self;
    [self.view addSubview:userName];
    [userName release];
    
    
    //phoneNumber
    phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(50, height+60, 220, 43)];
    phoneNumber.placeholder = @"密码";
    //phoneNumber.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"type.png"]];
    //phoneNumber.leftViewMode = UITextFieldViewModeAlways;
    phoneNumber.font = [UIFont fontWithName:@"Helvetica" size:30];
    phoneNumber.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"textbg.png"]];
    phoneNumber.borderStyle = UITextBorderStyleNone;
    phoneNumber.keyboardType = UIKeyboardTypeNamePhonePad;
    phoneNumber.returnKeyType = UIReturnKeyDone;
    phoneNumber.textAlignment = NSTextAlignmentLeft;
    phoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNumber.delegate = self;
    [self.view addSubview:phoneNumber];
    [phoneNumber release];
    
    //RePhoneNumber
    if (![buttonTitle isEqualToString:@"YES"]) {
        RePhoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(50, height+120, 220, 43)];
        RePhoneNumber.placeholder = @"确认密码";
        //RePhoneNumber.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"type.png"]];
        //RePhoneNumber.leftViewMode = UITextFieldViewModeAlways;
        RePhoneNumber.font = [UIFont fontWithName:@"Helvetica" size:30];
        RePhoneNumber.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"textbg.png"]];
        RePhoneNumber.borderStyle = UITextBorderStyleNone;
        RePhoneNumber.keyboardType = UIKeyboardTypeNamePhonePad;
        RePhoneNumber.returnKeyType = UIReturnKeyDone;
        RePhoneNumber.textAlignment = NSTextAlignmentLeft;
        RePhoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
        RePhoneNumber.delegate = self;
        [self.view addSubview:RePhoneNumber];
        [RePhoneNumber release];
    }
    //submit
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submitButton setFrame:CGRectMake(50, height+distance, 220, 43)];
    submitButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"textbg.png"]];
    submitButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [submitButton setTitle:buttonTitle forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    
    Prompt *p = [[Prompt alloc] init];
    [self.view addSubview:p];
    [p release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) submit {
    
    if ([userName.text isEqualToString: @""]) {
        UIAlertView *alertDialog;
        alertDialog = [[UIAlertView alloc]
                       initWithTitle:@"提醒" message:@"请输入用户名！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertDialog show];
        [alertDialog release];
    } else if ([phoneNumber.text isEqualToString:@""]) {
        UIAlertView *alertDialog;
        alertDialog = [[UIAlertView alloc]
                       initWithTitle:@"提醒" message:@"请输入密码！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertDialog show];
        [alertDialog release];
    } else if (!isRegistered && ![RePhoneNumber.text isEqualToString:phoneNumber.text]) {
        UIAlertView *alertDialog;
        alertDialog = [[UIAlertView alloc]
                       initWithTitle:@"提醒" message:@"确认密码不匹配！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertDialog show];
        [alertDialog release];
    }
    NSString *result = @"";
//    if (isRegistered) {
//        LoginAction *logins = [[LoginAction alloc] init];
//        result = [logins loginActionWithAgent:@"8090app" withKey:@"zmfznliskbs1w37982f1bgxvnwle2m31" withUsername:userName.text withPassword:phoneNumber.text withServer:@""];
//    } else {
//        RegisterAction *registers = [[RegisterAction alloc] init];
//        result = [registers registerActionWithAgent:@"8090app" withKey:@"zmfznliskbs1w37982f1bgxvnwle2m31" withUsername:userName.text withPassword:phoneNumber.text withRepassword:RePhoneNumber.text withServer:@""];
//    }
    
    [self stateShow:result];
}

- (void) stateShow:(NSString *)result {
    if ([result isEqualToString:@"101"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    } else if ([result isEqualToString:@"102"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"帐号只能为字母加数字" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    } else if ([result isEqualToString:@"103"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"帐号长度超过限制" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    } else if ([result isEqualToString:@"104"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"帐号已存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    } else if ([result isEqualToString:@"105"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码长度不符合要求" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    } else if ([result isEqualToString:@"106"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码与确认密码不符" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    } else if ([result isEqualToString:@"107"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"系统关闭注册登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    } else if ([result isEqualToString:@"108"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"系统错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    } else if ([result isEqualToString:@"109"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录失败帐号或密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    } else if ([result isEqualToString:@"110"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"Sign加密错" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
    MainViewController *main = [[MainViewController alloc] init];
    [self presentModalViewController:main animated:NO];
    [main release];
}


#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];
	return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 90 - (self.view.frame.size.height - 216.0);//键盘高度216
    [UIView beginAnimations:@"incForKeyBoard" context:nil];
    [UIView setAnimationDuration:0.30f];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView beginAnimations:@"decForKeyBoard" context:nil];
    [UIView setAnimationDuration:0.30f];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    CGRect rect = CGRectMake(0.0f, 20.0f,width,height);
    self.view.frame = rect;
    [UIView commitAnimations];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ((range.location >= 24 && textField == userName)) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, 24)];
        return NO;
    } else if ((range.location >= 32 && textField == phoneNumber)||(range.location >= 32 && textField == RePhoneNumber)) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, 32)];
        return NO;
    } else 
    return  YES;
}



////只容许输入数字 的处理
//#define NUMBERS @"0123456789\n"
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSCharacterSet *cs;
//    if(textField == phoneNumber || textField == RePhoneNumber)
//    {
//        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        BOOL basicTest = [string isEqualToString:filtered];
//        if(!basicTest)
//        {
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                            message:@"请输入数字"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil];
//            
//            [alert show];
//            [alert release];
//            return NO;
//        } else if (range.location >= 11) {
//            //textField.text = [textField.text substringWithRange:NSMakeRange(0, 11)];
//            return NO;
//        }
//    }
//    //其他的类型不需要检测，直接写入
//    return YES;
//}


@end
