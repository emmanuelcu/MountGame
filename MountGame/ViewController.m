//
//  ViewController.m
//  MountGame
//
//  Created by Emmanuel Cuevas on 10/31/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import "ViewController.h"
#import "PathView.h"
#import "MountainPath.h"


#define MAP_STARTING_SCORE 15000
#define MAP_SCORE_DECREMENT_AMOUNT 100
#define TIMER_INTERVAL 0.1
#define WALL_PENALTY 500


@interface ViewController ()
@property (strong, nonatomic) IBOutlet PathView *pathView;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self.pathView addGestureRecognizer:tapRecognizer];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [self.pathView addGestureRecognizer:panRecognizer];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", MAP_STARTING_SCORE];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapDetected:(UIGestureRecognizer *)tapRecognizer{
    NSLog(@"Tapped!");
    CGPoint tapLocation = [tapRecognizer locationInView:self.pathView];
    
    NSLog(@"Tap location is at (%f , %f)", tapLocation.x , tapLocation.y);
}

-(void)panDetected:(UIPanGestureRecognizer *)panRecognizer{
    CGPoint fingerLocation = [panRecognizer locationInView:self.pathView];
    
    if (panRecognizer.state == UIGestureRecognizerStateBegan && fingerLocation.y < 750)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", MAP_STARTING_SCORE];
    }
    else if (panRecognizer.state == UIGestureRecognizerStateChanged)
    {
        for(UIBezierPath *path in [MountainPath mountainPathsForRect:self.pathView.bounds]){
            UIBezierPath *tapTarget = [MountainPath tapTargetForPath:path];
            if ([tapTarget containsPoint:fingerLocation]) {
                //            NSLog(@"You hit the wall!!");
                [self decrementScoreByAmount:WALL_PENALTY];
            }
            
        }
    }
    else if (panRecognizer.state == UIGestureRecognizerStateEnded && fingerLocation.y <=165)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Make sure to start at the bottom of the path, hold your finger down and finish at the top of the path!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [self.timer invalidate];
        self.timer = nil;
        
    }
    
    
    
//    NSLog(@"I'm at (%f , %f)", fingerLocation.x , fingerLocation.y);

    
}

-(void)timerFired
{
    NSLog(@"Fired");
}

-(void)decrementScoreByAmount:(int)amount
{
    NSString *scoreText = [[self.scoreLabel.text  componentsSeparatedByString:@" "] lastObject];
    int score = [scoreText intValue];
    score = score - amount;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i",score];
}

@end
