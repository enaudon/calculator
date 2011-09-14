//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject {
    double operand1;  //first operand
    double operand2;  //second operand
    NSString *waitingOperation;  //operation storage for
                                 //2-operand operations
}

//setter for operand variable
- (void) setOperand:(double)operand;

//attempts to perform the specified operation
- (double) performOperation:(NSString *)operation;

@end
