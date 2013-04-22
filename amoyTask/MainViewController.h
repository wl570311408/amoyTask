//
//  MainViewController.h
//  amoyTask
//
//  Created by wuliang on 13-4-11.
//  Copyright (c) 2013年 wuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
{
    UILabel *noticeLabel;
    NSString *notice;
    int step;
    NSTimer *noticeTimer;
}





@property (retain, nonatomic) IBOutlet UIButton *creditsButton;
@property (retain, nonatomic) IBOutlet UIScrollView *noticeBoardButton;



- (IBAction)availableAction:(UIButton *)sender;
- (IBAction)waitForReviewAction:(UIButton *)sender;
- (IBAction)finishedAction:(UIButton *)sender;
- (IBAction)failedAction:(UIButton *)sender;
- (IBAction)creditsExchangeAction:(UIButton *)sender;
- (IBAction)memberCenterAction:(UIButton *)sender;



@end
