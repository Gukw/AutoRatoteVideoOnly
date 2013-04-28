//
//  autoRatoteMPMoviePlayerViewController.m
//  AutoRatoteVideoOnly
//
//  IOS开发群，克伟提供：http://stackoverflow.com/questions/3005389/detecting-rotation-to-landscape-manually
//  6.0-系统会自动旋转
//  6.0+系统需要自行判断，然后手动旋转
//  Created by Gukw on 4/28/13.
//  Copyright (c) 2013 iphone. All rights reserved.
//

#import "AutoRatoteMPMoviePlayerViewController.h"

@implementation AutoRatoteMPMoviePlayerViewController
-(id)initWithContentURL:(NSURL *)contentURL{
    self = [super initWithContentURL:contentURL];
    if(self){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation) name:UIDeviceOrientationDidChangeNotification object:nil];
        self.view.backgroundColor = [UIColor redColor];
        _delegateController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return self;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    NSLog(@"dealloc:%@", NSStringFromClass([self class]));
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self detectOrientation];
}
-(void)detectOrientation{
    if([[[UIDevice currentDevice] systemVersion] floatValue] <= 6.0){
        return;
    }

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:2];
    UIDeviceOrientation tointerfaceOrientation = [[UIDevice currentDevice] orientation];
    NSLog(@"detectOrientation to : %d", tointerfaceOrientation);
    if(tointerfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        self.view.transform  = CGAffineTransformMakeRotation(-M_PI_2);
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
        self.view.bounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    }else if(tointerfaceOrientation == UIInterfaceOrientationLandscapeRight){
        self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        self.view.bounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    }else if(tointerfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
//        self.view.transform = CGAffineTransformMakeRotation(M_PI);
//        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortraitUpsideDown];
//        self.view.bounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }
    else if(tointerfaceOrientation == UIInterfaceOrientationPortrait){
        self.view.transform = CGAffineTransformMakeRotation(0);
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        self.view.bounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }
    [UIView commitAnimations];
}
//return 0后，[[UIApplication sharedApplication] setStatusBarOrientation]才会起作用。
-(NSUInteger)supportedInterfaceOrientations{
    return 0;
}

-(void)play{
    MPMoviePlayerController *player = [self moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:[self moviePlayer]];
    [player play];
    player.movieSourceType = MPMovieSourceTypeUnknown;

    [_delegateController presentMoviePlayerViewControllerAnimated:self];//呈现这个影片播放视图
}
- (void)moviePlayerDidFinish:(NSNotification *)aNote{
    MPMoviePlayerController *player = [aNote object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:player];
    [player stop];
    [_delegateController dismissMoviePlayerViewControllerAnimated];
}
@end
