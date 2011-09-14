//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain

/*Clears the operand variables and waitingOperation.
 */
- (void) clear
{
    operand1 = 0;
    operand2 = 0;
    waitingOperation = nil;
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
        operand2 = operand1 + operand2;
    
    //handle subtraction
    else if ([waitingOperation isEqual:@"-"])
        operand2 = operand1 - operand2;
    
    //handle multiplication
    else if ([waitingOperation isEqual:@"*"])
        operand2 = operand1*operand2;
    
    //handle division
    //note: fail silently for division by zero
    //(fix that)
    else if ([waitingOperation isEqual:@"/"])
        if (operand2)
            operand2 = operand1/operand2;
}

/*Setter for the operand variable.
 *
 *@param operand the new value of operand.
 */
- (void) setOperand:(double)operand {operand2 = operand;}

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
    if ([operation isEqual:@"sqrt"])
        operand2 = sqrt(operand2);
    
    //handle negation
    //NOTE: this is not implemented yet!
    else if ([operation isEqual:@"(-)"])
        operand2 = - operand2;
    
    //handle inversion
    //note: fail silently for division by zero
    //(fix that)
    else if ([operation isEqual:@"1/x"])
        if (operand2)
            operand2 = 1/operand2;
        //yes, this is sloppy, i know.  i'll get to it.
        else {}
    
    //handle sine
    else if ([operation isEqual:@"sin"])
        operand2 = sin(operand2);
    
    //handle cosine
    else if ([operation isEqual:@"cos"])
        operand2 = cos(operand2);
    
    //handle tangent
    else if ([operation isEqual:@"tan"])
        operand2 = tan(operand2);
    
    //handle 2-operand operations
    else {
        [self performWaitingOperation];
        waitingOperation = operation;
        operand1 = operand2;
    }
    return operand2;
}

@end
