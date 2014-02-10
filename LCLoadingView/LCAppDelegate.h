//
//  LCAppDelegate.h
//  LCLoadingView
//
//  Created by lc on 14-2-10.
//  Copyright (c) 2014年 lc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingViewController.h"

@interface LCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) LoadingViewController *loadVC;

@end
