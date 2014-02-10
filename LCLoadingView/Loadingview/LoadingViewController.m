//
//  LoadingViewController.m
//  MyDemo
//
//  Created by lc on 12-8-13.
//  Copyright (c) 2012年 LC. All rights reserved.
//

#import "LoadingViewController.h"
#import "LCLoadingView.h"

@interface LoadingViewController ()

@property (retain, nonatomic) IBOutlet UIButton *button;
@property(nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) LCLoadingView *loadingView;

@end

@implementation LoadingViewController

@synthesize loadingView = _loadingView;
@synthesize window = _window;

- (IBAction)buttonDown:(id)sender
{
    [self addLoadingView];
    [self performSelector:@selector(deleteLoadingView) withObject:nil afterDelay:3];
}

-(void)addLoadingView
{
    CGRect rec = CGRectMake(0, 0, 80, 80);
    _loadingView = [[LCLoadingView alloc]initWithFrame:rec];
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.windowLevel = UIWindowLevelAlert;
    [_window addSubview:_loadingView];
    _loadingView.center = _window.center;
    [_window makeKeyAndVisible];
    [_loadingView showView:YES];
}

-(void)deleteLoadingView
{
    [_loadingView showView:NO];
    self.loadingView = nil;
    self.window = nil;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_button release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setButton:nil];
    [super viewDidUnload];
}
@end
