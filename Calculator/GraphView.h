//
//  GraphView.m
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxesDrawer.h"

#define MINIMUM_SCALE 1
#define DEFAULT_SCALE 18
#define MAXIMUM_SCALE 333
#define SCALE_KEY     @"scale"
#define X_ORIGIN_KEY  @"origin_x"
#define Y_ORIGIN_KEY  @"origin_y"

@class GraphView;

@protocol GraphViewDelegate
  - (CGFloat) yValueForX:(float)x;
  - (BOOL) dotDraw;

@end


@interface GraphView : UIView <UIGestureRecognizerDelegate> {

@private
  id <GraphViewDelegate> delegate;
  CGPoint origin;
  CGPoint offset;
  float scale;
}

//private property
@property (assign) float scale;
@property (assign) id <GraphViewDelegate> delegate;

@end
