//
//  PathView.m
//  MountGame
//
//  Created by Emmanuel Cuevas on 10/31/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import "PathView.h"
#import "MountainPath.h"


@implementation PathView


-(id) initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        //initialization code
        
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setup];
    }
    return self;
}

-(void)setup{
    self.backgroundColor = [UIColor clearColor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (UIBezierPath *path in [MountainPath mountainPathsForRect:self.bounds]) {
        [[UIColor blackColor] setStroke];
        [path stroke];
    }
}


@end
