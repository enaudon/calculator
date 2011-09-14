//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain

- (void) performWaitingOperation {
    if ([waitingOperation isEqual:@"+"])
        operand = waitingOperand + operand;
    else if ([waitingOperation isEqual:@"-"])
        operand = waitingOperand - operand;
    else if ([waitingOperation isEqual:@"*"])
        operand = waitingOperand*operand;
    else if ([waitingOperation isEqual:@"/"])
        if (operand)
            operand = waitingOperand/operand;
}

- (void) setOperand:(double)aDouble {
    operand = aDouble;
}

- (double) performOperation:(NSString *)operation {
    if ([operation isEqual:@"sqrt"])
        operand = sqrt(operand);
    else if ([operation isEqual:@"+/-"])
        operand = - operand;
    else {
        [self performWaitingOperation];
        waitingOperation = operation;
        waitingOperand = operand;
    }
    return operand;
}

@end
