//
//  TermDetailViewController.h
//  sportsguide
//
//  Created by prudhvi on 5/15/15.
//  Copyright (c) 2015 gits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@class Term;

@interface TermDetailViewController : UIViewController<ADBannerViewDelegate>

@property (nonatomic, strong) Term *term;

@end
