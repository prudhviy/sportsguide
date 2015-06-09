//
//  TermDetailViewController.m
//  sportsguide
//
//  Created by prudhvi on 5/15/15.
//  Copyright (c) 2015 gits. All rights reserved.
//

#import <iAd/iAd.h>
#import "TermDetailViewController.h"
#import "Term.h"

@interface TermDetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *termName;
@property (weak, nonatomic) IBOutlet UILabel *termDetail;
@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;

@property (nonatomic, strong) ADBannerView *adView;
@property (nonatomic, assign) BOOL _bannerIsVisible;

@end

@implementation TermDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        
        // Set the tab bar item's title
        //self.tabBarItem.title = @"Facts";
        //self.tabBarItem.image = [UIImage imageNamed:@"facts.png"];
        
        // Create a UIImage from a file
        // This will use Hypno@2x.png on retina display devices
        //UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        
        // Put that image on the tab bar item
        //self.tabBarItem.image = i;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.canDisplayBannerAds = YES;
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = self.contentView.frame.size;
    if(![self.term.video isEqualToString: @"none"]) {
        [self.playerView loadWithVideoId:self.term.video];
    } else {
        [self.playerView removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Term *term = self.term;
    
    self.termName.text = term.name;
    self.termDetail.text = term.detail;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, [[UIScreen mainScreen] bounds].size.width, 50)];
    self.adView.delegate = self;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!self._bannerIsVisible) {
        // If banner isn't part of view hierarchy, add it
        if (self.adView.superview == nil) {
            [self.view addSubview: self.adView];
        }
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        
        [UIView commitAnimations];
        
        self._bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"Failed to retrieve ad");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
