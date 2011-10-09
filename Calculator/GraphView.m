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

/*Draws the specified axis.
 *
 *@param axis the axis to draw
 */
- (void) drawAxis:(short)axis
{
  
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
	
  /*
	CGFloat size = self.bounds.size.width / 2;
	if (self.bounds.size.height < self.bounds.size.width)
    size = self.bounds.size.height / 2;
	size *= 0.90;
  */
	
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
}

- (void) dealloc
{
  [super dealloc];
}

@end
