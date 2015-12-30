//
//  MountainPath.h
//  MountGame
//
//  Created by Emmanuel Cuevas on 10/31/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MountainPath : NSObject

+(NSArray *)mountainPathsForRect:(CGRect)rect;

+(UIBezierPath *)tapTargetForPath:(UIBezierPath *)path;

@end
