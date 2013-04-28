//
//  autoRatoteMPMoviePlayerViewController.h
//  AutoRatoteVideoOnly
//
//  Created by Gukw on 4/28/13.
//  Copyright (c) 2013 iphone. All rights reserved.
//
#import <MediaPlayer/MediaPlayer.h>
@interface AutoRatoteMPMoviePlayerViewController : MPMoviePlayerViewController
//如果触发视频的viewcontroller是被present的话，需要把该controller传过来，否则，视频弹出后看不到。
@property (nonatomic) UIViewController *delegateController;
-(void)play;
@end
