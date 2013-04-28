//
//  MainViewController.m
//  AutoRatoteVideoOnly
//
//  Created by Gukw on 4/28/13.
//  Copyright (c) 2013 iphone. All rights reserved.
//

#import "MainViewController.h"
#import "AutoRatoteMPMoviePlayerViewController.h"
@implementation MainViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
    }
    return self;

}
-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor yellowColor];
    UIButton *play = [UIButton buttonWithType:UIButtonTypeContactAdd];
    play.frame = CGRectMake(100, 100, play.frame.size.width, play.frame.size.height);
    [self.view addSubview:play];
    [play addTarget:self action:@selector(handlePlay) forControlEvents:UIControlEventTouchUpInside];

}
-(void)handlePlay{
    NSURL *movieURL = [NSURL URLWithString:@"http://haobao.com/images/video/20130311/f80b8551-f4de-455d-873e-84f9d2531516.mp4"];
    AutoRatoteMPMoviePlayerViewController *playerViewController = [[AutoRatoteMPMoviePlayerViewController alloc] initWithContentURL:movieURL];
    playerViewController.delegateController = self;
    [playerViewController play];
}

@end
