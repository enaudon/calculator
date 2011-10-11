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


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*--------------------------{ PRIVATE METHODS }--------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Graphs a curve through the specified points.
 *
 *@param numPts the number of points
 *@param points the points the curve intersects
 */
- (void) drawCurveInContext:(CGContextRef)context
{
  //convert initial display x-value (0) to coordinate value
  float disp_x  = 0,
        coord_x = (disp_x - origin.x)/SCALE;

  //convert initial coordinate y-value to display value
  float coord_y = [delegate yValueForX:coord_x],
        disp_y  = coord_y*SCALE + origin.y - 2*(coord_y*SCALE);

  //push context and start path
	UIGraphicsPushContext(context);
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, disp_x, disp_y);
  
  //build path
  register int i;
  for (i = 1; i <= 2*origin.x; ++i) {
    
    //grab display x-value and convert to coordinate x-value
    disp_x = i;
    coord_x = (disp_x - origin.x)/SCALE;
    
    //get coordinate y-value from delegate and convert to display y-value
    coord_y = [delegate yValueForX:coord_x];
    disp_y  = coord_y*SCALE + origin.y - 2*(coord_y*SCALE);
    
    //connect display point to curve
    CGContextAddLineToPoint(context, disp_x, disp_y);
  }
  
  //draw curve and pop context
	CGContextStrokePath(context);
	UIGraphicsPopContext();
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*---------------------------{ OTHER METHODS }---------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Draws a set of (x,y) axes into the specified rect.
 *
 *@param rect the rect to draw into
 */
- (void) drawRect:(CGRect)rect
{
  //get origin
  CGPoint temp;
  temp.x = self.bounds.size.width/2;
  temp.y = self.bounds.size.height/2;
  origin = temp;
	
  //get context
	CGContextRef context = UIGraphicsGetCurrentContext();
  
  //draw axes
  [AxesDrawer drawAxesInRect:rect
               originAtPoint:origin
                       scale:SCALE];
  
  //draw curve
  [self drawCurveInContext:context];
}

/*Destructor.
 */
- (void) dealloc
{
  self.delegate = nil;
  [super dealloc];
}

@end
