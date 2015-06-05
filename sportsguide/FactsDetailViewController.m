//
//  FactsDetailViewController.m
//  sportsguide
//
//  Created by prudhvi on 6/5/15.
//  Copyright (c) 2015 gits. All rights reserved.
//

#import "FactsDetailViewController.h"

@interface FactsDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *factLabel;

@end

@implementation FactsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.factLabel.text = self.fact;
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
