//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.

#import "CalculatorBrain.h"


@implementation CalculatorBrain
  @synthesize operand = operand1;
  @synthesize waitingOperation;

/*Clears the operand variables, waitingOperation and memory.
 */
- (void) clear
{
    operand1 = 0;
    operand2 = 0;
    self.waitingOperation = nil;
}

/*Attempts to perform 2-operand operations.
 *If only one operand has been specified, nothing is done.
 *Also, note that the result of the calculation is stored
 *in the operand variable.
 *This method is private.
 */
- (void) performWaitingOperation
{    
    //handle addition
    if ([waitingOperation isEqual:@"+"])
        operand1 = operand2 + operand1;
    
    //handle subtraction
    else if ([waitingOperation isEqual:@"-"])
      operand1 = operand2 - operand1;
    
    //handle multiplication
    else if ([waitingOperation isEqual:@"*"])
      operand1 = operand2*operand1;
    
    //handle division
    //note: fail silently for division by zero
    //(fix that)
    else if ([waitingOperation isEqual:@"/"])
      if (operand1)
        operand1 = operand2/operand1;
}

/*Attempts to perform the specified operation.
 *If a 2-operand operation is requested, performWaitingOperation
 is called.
 *
 *@param operation the operation to be performed
 *@return          the result of the calculation
 */
- (double) performOperation:(NSString *)operation
{    
    //handle square root
    if ([operation isEqual:@"√x"])
      operand1 = sqrt(operand1);
    
    //handle square
    else if ([operation isEqual:@"x²"])
      operand1 = pow(operand1, 2);
    
    //handle negation
    //NOTE: this is not implemented yet!
    else if ([operation isEqual:@"(-)"])
      operand1 = - operand1;
    
    //handle inversion
    //note: fail silently for division by zero
    //(fix that)
    else if ([operation isEqual:@"1/x"])
      if (operand1)
        operand1 = 1/operand1;
      //yes, this is sloppy, i know.  i'll get to it.
      else {}
    
    //handle sine
    else if ([operation isEqual:@"sin"])
      operand1 = sin(operand1);
    
    //handle cosine
    else if ([operation isEqual:@"cos"])
      operand1 = cos(operand1);
    
    //handle tangent
    else if ([operation isEqual:@"tan"])
      operand1 = tan(operand1);
  
    //handle storage
      else if ([operation isEqual:@"Str"])
        memory = operand1;
  
    //handle recall
      else if ([operation isEqual:@"Rcl"])
        operand1 = memory;
    
    //handle addition
      else if ([operation isEqual:@"M+"]) {
        operand1 = memory + operand1;
        memory = operand1;
      }
    
    //handle subtraction
      else if  ([operation isEqual:@"M-"]) {
        operand1 = memory - operand1;
        memory = operand1;
      }
    
    //handle 2-operand operations
    else {
      [self performWaitingOperation];
      self.waitingOperation = operation;
      operand2 = operand1;
    }
    
    return operand1;
}

/*Destructor.
 */
- (void) dealloc
{
  //release instance variables
  [waitingOperation release];
  
  //call super-class' destructor
  [super dealloc];
}

@end
