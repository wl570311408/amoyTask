//
//  MainViewController.m
//  amoyTask
//
//  Created by wuliang on 13-4-11.
//  Copyright (c) 2013年 wuliang. All rights reserved.
//

#import "MainViewController.h"


#import "AvailableViewController.h"
#import "WaitForReviewViewController.h"
#import "FinishedViewController.h"
#import "FailedViewController.h"
#import "CreditsExchangeViewController.h"
#import "MemberCenterViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize creditsButton = _creditsButton, noticeBoardButton = _noticeBoardButton;

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
    [self.navigationController setHidesBottomBarWhenPushed:YES];
    
    NSMutableArray *noticeArray = [[NSMutableArray alloc] initWithObjects:
                                   @"          用户 139***091 兑换 10话费           ",
                                   @"          用户 139***092 兑换 10话费           ",
                                   @"          用户 139***093 兑换 10话费           ",
                                   @"          用户 139***094 兑换 10话费           ",
                                   @"          用户 139***095 兑换 10话费           ",
                                   @"          用户 139***096 兑换 10话费           ",
                                   @"          用户 139***097 兑换 10话费           ",
                                   @"          用户 139***098 兑换 10话费           ",
                                   @"          用户 139***099 兑换 10话费           ",
                                   @"          用户 139***090 兑换 10话费           ",
                                   nil];
    notice = @"";
    for (int i =0; i < noticeArray.count; i++) {
        notice = [NSString stringWithFormat:@"%@%@",notice,[noticeArray objectAtIndex:i]];
    }
    noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 3200, 45)];
    [noticeLabel setText:notice];
    [_noticeBoardButton addSubview:noticeLabel];
    [_noticeBoardButton setContentSize:noticeLabel.frame.size];
	[_noticeBoardButton setScrollEnabled:YES];
    
    
    step = 0;
    noticeTimer = [NSTimer timerWithTimeInterval:0.03 target:self selector:@selector(noticeControll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:noticeTimer forMode:NSRunLoopCommonModes];
}

- (void) noticeControll {
    if (step > noticeLabel.frame.size.width) {
        step = 0;
    } else {
        [_noticeBoardButton setContentOffset:CGPointMake(step++, 0)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)availableAction:(UIButton *)sender {
    AvailableViewController *available = [[AvailableViewController alloc] init];
    //[self.navigationController pushViewController:available animated:YES];
    [self presentViewController:available animated:NO completion:nil];
    [available release];
}

- (IBAction)waitForReviewAction:(UIButton *)sender {
    WaitForReviewViewController *available = [[WaitForReviewViewController alloc] init];
    [self.navigationController pushViewController:available animated:YES];
    [available release];
}

- (IBAction)finishedAction:(UIButton *)sender {
    FinishedViewController *available = [[FinishedViewController alloc] init];
    [self.navigationController pushViewController:available animated:YES];
    [available release];
}

- (IBAction)failedAction:(UIButton *)sender {
    FailedViewController *available = [[FailedViewController alloc] init];
    [self.navigationController pushViewController:available animated:YES];
    [available release];
}

- (IBAction)creditsExchangeAction:(UIButton *)sender {
    CreditsExchangeViewController *available = [[CreditsExchangeViewController alloc] init];
    [self.navigationController pushViewController:available animated:YES];
    [available release];
}

- (IBAction)memberCenterAction:(UIButton *)sender {
    MemberCenterViewController *available = [[MemberCenterViewController alloc] init];
    [self.navigationController pushViewController:available animated:YES];
    [available release];
}
- (void)dealloc {
    [_creditsButton release];
    [_noticeBoardButton release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setCreditsButton:nil];
    [self setNoticeBoardButton:nil];
    [super viewDidUnload];
}
@end
