//
//  ViewController.m
//  MountGame
//
//  Created by Emmanuel Cuevas on 10/31/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import "ViewController.h"
#import "PathView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet PathView *pathView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    [self.pathView addGestureRecognizer:tapRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapDetected:(UIGestureRecognizer *)tapRecognizer{
    NSLog(@"Tapped!");
}

@end
