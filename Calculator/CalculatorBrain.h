//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject {
  @public
    double operand1;  //first operand
  @private
    double operand2;  //second operand
    NSString *waitingOperation;  //operation storage for
                                 //2-operand operations
    double memory;  //storage for the calculator
}
//public properties
@property double operand1;

//private properties
@property (retain) NSString *waitingOperation;

//clears operands and waitingOperation
- (void) clear;

//returns the result of the specified operation
- (double) performOperation:(NSString *)operation;

//returns the result of the specified memory-operation
- (double) performMemOp:(NSString *)operation;

@end
