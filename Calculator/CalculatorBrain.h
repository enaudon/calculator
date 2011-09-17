//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject {
  @private
    double operand1;  //first operand
    double operand2;  //second operand
    NSString *waitingOperation;  //operation storage for
                                 //2-operand operations
    double memory;  //storage for the calculator
}
@property double operand1;  //first operand
@property double memory;  //storage for the calculator

//clears operands and waitingOperation
- (void) clear;

//returns the result of the specified memory-operation
- (double) performMemOp:(NSString *)operation;

//returns the result of the specified operation
- (double) performOperation:(NSString *)operation;

@end
