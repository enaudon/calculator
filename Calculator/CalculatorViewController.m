//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

- (CalculatorBrain *) brain {
    if (!brain) brain = [[CalculatorBrain alloc] init];
    return brain;
}

- (IBAction) digitPressed:(UIButton *)sender {
    NSString *digit = [[sender titleLabel] text];
    if (typing)
        [display setText:[[display text]
                          stringByAppendingString:digit]];
    else {
        [display setText:digit];
        typing = 1;
    }
}

- (IBAction) operationPressed:(UIButton *)sender {
    if (typing) {
        double operand = [[display text] doubleValue];
        [[self brain] setOperand:operand];
        typing = 0;
    }
    NSString *operation = [[sender titleLabel] text];
    double result = [[self brain] performOperation:operation];
    [display setText:[NSString stringWithFormat:@"%g", result]];
}

@end
