//
//  DukeViewController.m
//  VedioPlayer
//
//  Created by Donghe on 2/3/13.
//  Copyright (c) 2013 Data and GIS Lab. All rights reserved.
//

#import "DukeViewController.h"


@interface DukeViewController ()
@property (weak, nonatomic) IBOutlet UIView *vedioView;
@property (strong, nonatomic) AVPlayer *player;
@property (weak, nonatomic) IBOutlet UISlider *playerProgressSlider;

@end

@implementation DukeViewController

@synthesize vedioView = _vedioView;
@synthesize player = _player;
@synthesize playerProgressSlider = _playerProgressSlider;


- (IBAction)playVedio:(UIButton *)sender
{
    if(self.player.currentTime.value != 0) return;
    self.playerProgressSlider.value = 0;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"vedio" ofType:@"MOV"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];

    AVAsset *movieAsset    = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.vedioView.layer.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.vedioView.layer addSublayer:playerLayer];
    [self.player play];
    
    
    
//    NSTimer *sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateAudioSlider) userInfo:nil repeats:YES];
//    [sliderTimer fire];
}

- (IBAction)playerRateChanged:(UISlider *)sender
{
    self.player.rate = sender.value - 0.5 + 1;
}


-(void)updateAudioSlider
{
    float current = self.player.currentTime.value;
    float total = self.player.currentItem.asset.duration.value;
    NSLog(@"%f",current);
    NSLog(@"%f",total);
    self.playerProgressSlider.value = current / total;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setVedioView:nil];
    [self setPlayerProgressSlider:nil];
    [super viewDidUnload];
}
@end
