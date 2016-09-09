//
//  ViewController.m
//  GIFDemo
//
//  Created by 韩金波 on 16/9/1.
//  Copyright © 2016年 Psylife. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
#import "KBWave.h"
@interface ViewController ()
@property(nonatomic,strong)UIImageView *loadingImageView;

@property (nonatomic, strong) KBWave *headerView;

@property (nonatomic, strong) UIImageView *iconImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self next];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initLoadingImageView

{
    
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"ee" ofType:@"gif"];
    
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    
    self.loadingImageView = [[UIImageView alloc]init];
    self.loadingImageView.frame = CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height);
    
    self.loadingImageView.backgroundColor = [UIColor redColor];
    self.loadingImageView.contentMode = UIViewContentModeScaleAspectFill;
    //第一种方法使用imageData加载
    self.loadingImageView.image = [UIImage sd_animatedGIFWithData:imageData];

    //第二种方法使用图片名字加载
    //self.loadingImageView.image = [UIImage sd_animatedGIFNamed:@"2"];
    
    [self.view addSubview:self.loadingImageView];
    
    [self.view bringSubviewToFront:self.loadingImageView];
    
    
    
}
- (UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.headerView.frame.size.width/2-30, 0, 60, 60)];
        _iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _iconImageView.layer.borderWidth = 2;
        _iconImageView.layer.cornerRadius = 20;
    }
    return _iconImageView;
}

- (KBWave *)headerView{
    
    if (!_headerView) {
        _headerView = [[KBWave alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        
        _headerView.backgroundColor = KBColor(248, 64, 87, 1);
        [_headerView addSubview:self.iconImageView];
        
        
        __weak typeof(self)weakSelf = self;
        _headerView.waveBlock = ^(CGFloat currentY){
            
            CGRect iconFrame = [weakSelf.iconImageView frame];
            
            iconFrame.origin.y = CGRectGetHeight(weakSelf.headerView.frame)-CGRectGetHeight(weakSelf.iconImageView.frame)+currentY-weakSelf.headerView.waveHeight;
            
            weakSelf.iconImageView.frame  =iconFrame;
        };
        [_headerView startWaveAnimation];
    }
    return _headerView;
}

-(void)next{
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor greenColor];
////    vc.modalPresentationStyle = UIModalPresentationCurrentContext;
//    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    
//    [self presentViewController:vc animated:YES completion:nil];
    [self.view addSubview:self.headerView];
}

@end
