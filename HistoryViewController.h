//
//  HistoryViewController.h
//  SaveMoney
//
//  Created by HARADA SHINYA on 11/13/12.
//  Copyright (c) 2012 HARADA SHINYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "User.h"
#import "Helper.h"
#import "Admob.h"
#import "Drink.h"


@interface HistoryViewController : UIViewController<UIWebViewDelegate>


-(void)refreshPage;
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) id delegate;

@end
