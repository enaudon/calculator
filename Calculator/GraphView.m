//
//  GraphView.m
//  Calculator
//
//  Created by Enrique S. Naudon on 10/9/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import "GraphView.h"


@implementation GraphView

- (id) initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

/*Graphs a curve through the specified points.
 *
 *@param numPts the number of points
 *@param points the points the curve intersects
 */
- (void) graphCurveThroughThese:(short)numPts
                         Points:(CGPoint[])points
{
  //point selector variable
  CGPoint *pt = points;
  
  //get context and start path
	CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, pt->x, pt->y);
  
  //build path
  register int i;
  for (i = 1; i < numPts; ++i) {
    pt = &points[i];
    CGContextAddLineToPoint(context, pt->x, pt->y);
  }
  
  //draw curve
  CGContextDrawPath(context, kCGPathStroke);
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
  
  //test graphing
  CGPoint pt[10];
  
  pt[0].x = 0; pt[0].y = height;
  pt[1].x = 0; pt[1].y = height;
  pt[2].x = 0; pt[2].y = height;
  
  pt[3].x = origin.x; pt[3].y = origin.y;
  pt[4].x = origin.x; pt[4].y = origin.y;
  pt[5].x = origin.x; pt[5].y = origin.y;
  
  pt[6].x = width; pt[6].y = 0;
  pt[7].x = width; pt[7].y = 0;
  pt[8].x = width; pt[8].y = 0;
  
  pt[9].x = 30; pt[9].y = 30;
  
  [self graphCurveThroughThese:10
                        Points:pt];
}

- (void) dealloc
{
  [super dealloc];
}

@end
