//
//  LoginController.h
//  豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeStatus)(BOOL status);

@interface LoginController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, copy) ChangeStatus changeStatus;

@end
