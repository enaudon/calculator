//
//  GraphView.m
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import "GraphView.h"


@implementation GraphView

@synthesize delegate;

- (id) initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {}
    return self;
}

/*Graphs a curve through the specified points.
 *
 *@param numPts the number of points
 *@param points the points the curve intersects
 */
- (void) drawCurveInContext:(CGContextRef)context
{
  //points array and x/y selector variables
  NSArray *points = [self.delegate pointsForCurve:self];
  NSNumber *x = [points objectAtIndex: 0],
           *y = [points objectAtIndex: 1];
  
  //push context and start path
	UIGraphicsPushContext(context);
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, [x floatValue], [y floatValue]);
  
  //build path
  register int i;
  for (i = 1; i < [points count]/2; ++i) {
    
    //get point coordinates
    x = [points objectAtIndex: 2*i];
    y = [points objectAtIndex: 2*i+1];
    
    //add connect cuve to point
    CGContextAddLineToPoint(context, [x floatValue], [y floatValue]);
  }
  
  //draw curve and pop context
	CGContextStrokePath(context);
	UIGraphicsPopContext();
}

/*Draws a set of (x,y) axes into the specified rect.
 *
 *@param rect the rect to draw into
 */
- (void) drawRect:(CGRect)rect
{
  NSLog(@"draw");
  
  //get spacial information about the rect
	CGPoint origin;  //midpoint
	origin.x = self.bounds.origin.x + self.bounds.size.width/2;
	origin.y = self.bounds.origin.y + self.bounds.size.height/2;
  CGFloat width  = self.bounds.size.width;   //witdth
  CGFloat height = self.bounds.size.height;  //height
	
  //get context
	CGContextRef context = UIGraphicsGetCurrentContext();
  
  //draw x-axis
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, 0, origin.y);
  CGContextAddLineToPoint(context, width, origin.y);
  CGContextDrawPath(context, kCGPathFillStroke);
  
  //draw y-axis
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, origin.x, 0);
  CGContextAddLineToPoint(context, origin.x, height);
  CGContextDrawPath(context, kCGPathFillStroke);
  
  //draw curve
  [self drawCurveInContext:context];
}

- (void) dealloc
{
  [super dealloc];
}

@end
